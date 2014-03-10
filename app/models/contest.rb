class Contest < ActiveRecord::Base

  attr_accessible :name, :starts_at, :ends_at, :regulations

  validates :name, :starts_at, :ends_at, :regulations,
            presence: {message: I18n.t("errors.messages.blank")}
end
