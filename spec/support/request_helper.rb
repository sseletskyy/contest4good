require 'spec_helper'
include Warden::Test::Helpers

module RequestHelper

  def create_current_admin
    admin = fg.create :admin
    login_as(admin, :scope => :admin, :run_callbacks => true)
    admin
  end

  def create_current_user
    user = fg.create :user
    login_as(user, :scope => :user, :run_callbacks => true)
    user
  end

end