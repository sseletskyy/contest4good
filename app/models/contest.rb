class Contest < ActiveRecord::Base
  resourcify
  attr_accessible :name, :starts_at, :ends_at, :regulations, :committee_head

  attr_accessor :committee_head

  validates :name, :starts_at, :ends_at, :regulations,
            presence: {message: I18n.t("errors.messages.blank")}
end
