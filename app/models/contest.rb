class Contest < ActiveRecord::Base
  resourcify

  attr_accessible :name, :starts_at, :ends_at, :regulations,
                  :committee_head_ids, :jury_head_ids

  validates :name, :starts_at, :ends_at, :regulations,
            presence: {message: I18n.t("errors.messages.blank")}
  validates :committee_head_ids, :jury_head_ids, presence: {message: I18n.t("errors.messages.blank")}, on: :create

  after_save :save_role_committee_head
  after_save :save_role_jury_head

  # Custom getter/setter for role 'committee_head'
  def committee_head_ids
    @committee_head_ids ||= Admin.by_role(:committee_head, self).map(&:id)
  end

  def committee_head_ids=(ids)
    @committee_head_ids = ids
  end

  # Custom getter/setter for role 'jury_head'
  def jury_head_ids
    @jury_head_ids || Admin.by_role(:jury_head, self).map(&:id)
  end

  def jury_head_ids=(ids)
    @jury_head_ids = ids
  end

  private
  def save_roles(role)
    # committee_head admin
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
      end
    end
  end

  def save_role_committee_head
    save_roles(:committee_head)
  end

  def save_role_jury_head
    save_roles(:jury_head)
  end

end
