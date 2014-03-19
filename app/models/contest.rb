class Contest < ActiveRecord::Base
  resourcify

  attr_accessible :name, :starts_at, :ends_at, :regulations,
                  :committee_head_ids, :jury_head_ids,
                  :committee_vice_ids, :jury_judge_ids

  validates :name, :starts_at, :ends_at, :regulations,
            presence: {message: I18n.t("errors.messages.blank")}
  validates :committee_head_ids, :jury_head_ids,
            presence: {message: I18n.t("errors.messages.blank")}, on: :create

  validates :committee_head_ids, :jury_head_ids, :committee_vice_ids, :jury_judge_ids,
            presence: {message: I18n.t("errors.messages.blank")}, on: :update

  after_save :save_role_committee_head
  after_save :save_role_committee_vice
  after_save :save_role_jury_head
  after_save :save_role_jury_judge

  ### metaprogramming
  ## define getter/setter for roles
  [
      Contest4good::ROLE_COMMITTEE_HEAD,
      Contest4good::ROLE_JURY_HEAD,
      Contest4good::ROLE_COMMITTEE_VICE,
      Contest4good::ROLE_JURY_JUDGE
  ].each do |role|
    ### GETTER role_ids
    define_method("#{role}_ids") do
      # @committee_head_ids ||= Admin.by_role(:committee_head, self).map(&:id)
      instance_variable_get("@#{role}_ids") || instance_variable_set("@#{role}_ids", Admin.by_role(role.to_sym, self).map(&:id))
    end

    ### SETTER role_ids=
    define_method("#{role}_ids=") do |ids|
      # @committee_head_ids = ids.is_a?(Integer) && ids > 0 ? [ids] : ids
      instance_variable_set("@#{role}_ids", [ids].flatten.compact.reject(&:blank?))
    end

    ### role_ids_changed?
    define_method("#{role}_ids_changed?") do
      # @committee_head_ids != Admin.by_role(:committee_head, self).map(&:id)
      instance_variable_get("@#{role}_ids") != Admin.by_role(role.to_sym, self).map(&:id)
    end


    ### role_names
    define_method("#{role}_names") do
      #names = []
      #Admin.where(id: committee_head_ids).each {|admin| names << admin.admin_profile.full_name}
      #names
      names = []
      Admin.where(id: send("#{role}_ids")).each { |admin| names << admin.admin_profile.full_name }
      names
    end

  end
  ### end metaprogramming


  ## Custom getter/setter for role 'committee_head'
  #def committee_head_ids
  #  @committee_head_ids ||= Admin.by_role(:committee_head, self).map(&:id)
  #end
  #
  #def committee_head_ids=(ids)
  #  @committee_head_ids = ids.is_a?(Integer) && ids > 0 ? [ids] : ids
  #end
  #
  #def committee_head_names
  #  names = []
  #  Admin.where(id: committee_head_ids).each {|admin| names << admin.admin_profile.full_name}
  #  names
  #end
  #
  ## Custom getter/setter for role 'jury_head'
  #def jury_head_ids
  #  @jury_head_ids || Admin.by_role(:jury_head, self).map(&:id)
  #end
  #
  #def jury_head_ids=(ids)
  #  @jury_head_ids = ids.is_a?(Integer) && ids > 0 ? [ids] : ids
  #end
  #
  #def jury_head_names
  #  names = []
  #  Admin.where(id: jury_head_ids).each {|admin| names << admin.admin_profile.full_name}
  #  names
  #end

  private
  def save_roles(role)
    #update roles only if _ids variable was changed
    return unless self.send("#{role.to_s}_ids_changed?")

    role_ids = self.send("#{role.to_s}_ids")
    if (role_ids.nil? || role_ids.empty?)
      # remove all roles from admins
      admins = Admin.by_role(role, self)
      admins.each do |admin|
        admin.remove_role role, self
      end

    else
      # remove all roles from admins not in _ids
      admins = Admin.by_role(role, self).where("admins.id not IN (?)", role_ids)
      admins.each do |admin|
        admin.remove_role role, self
      end
      # add all roles to admins in _ids
      admins = Admin.where("admins.id IN (?)", role_ids)
      admins.each do |admin|
        admin.add_role role, self
        # send notification
        A::ContestMailer.send_ticket(self, admin, role).deliver
      end
    end
  end

  def save_role_committee_head
    save_roles(:committee_head)
  end

  def save_role_jury_head
    save_roles(:jury_head)
  end

  def save_role_committee_vice
    save_roles(:committee_vice)
  end

  def save_role_jury_judge
    save_roles(:jury_judge)
  end

end
