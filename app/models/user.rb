class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  ## Accessible attributes
  attr_accessible :password, :password_confirmation, :remember_me, :role_ids, :invitation_token,
                  :email

end
