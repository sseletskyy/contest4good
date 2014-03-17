class Role < ActiveRecord::Base
  has_and_belongs_to_many :admins, :join_table => :admins_roles
  belongs_to :resource, :polymorphic => true

  scopify

  scope :general, -> { where(name: Contest4good::ROLES_GENERAL) }
end
