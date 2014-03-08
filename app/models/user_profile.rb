class UserProfile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :first_name, :middle_name, :last_name, :born_on, :address, :school, :grade, :phone,
                  :parent_name, :parent_phone, :created_at, :updated_at, :user_id, :terms
  attr_accessor :terms

  validates :first_name, :middle_name, :last_name, :born_on, :address, :school, :grade, :phone,
            :parent_name, :parent_phone, presence: {message: I18n.t("errors.messages.blank")}

  validates :terms, presence: {message: I18n.t("errors.messages.accept_terms")}
end
