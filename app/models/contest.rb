class Contest < ActiveRecord::Base
  resourcify

  attr_accessible :name, :starts_at, :ends_at, :regulations,
                  :committee_head_ids, :jury_head_ids,
                  :committee_vice_ids, :jury_judge_ids

  validates :name, :starts_at, :ends_at, :regulations,
            presence: {message: I18n.t("errors.messages.blank")}
  validates :committee_head_ids, :jury_head_ids,
            presence: {message: I18n.t("errors.messages.blank")}, on: :create

  validates :committee_head_ids, presence: {message: I18n.t("errors.messages.blank")}, on: :update
  validates :jury_head_ids, presence: {message: I18n.t("errors.messages.blank")}, on: :update
  validate :committee_vice_ids_validation, on: :update
  validate :jury_judge_ids_validation, on: :update

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
      instance_variable_get("@#{role}_ids")
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
    ### return array of full names
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

  # validation method
  # it allows empty until the field was set
  def committee_vice_ids_validation
    if [committee_vice_ids].flatten.empty? && self.committee_vice_ids_changed?
      errors.add(:committee_vice_ids, I18n.t("errors.messages.blank"))
    end
  end

  # validation method
  # it allows empty until the field was set
  def jury_judge_ids_validation
    if [jury_judge_ids].flatten.empty? && self.jury_judge_ids_changed?
      errors.add(:jury_judge_ids, I18n.t("errors.messages.blank"))
    end
  end


end
