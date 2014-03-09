require 'spec_helper'
include Warden::Test::Helpers

module RequestHelper

  def create_current_user
    user = fg.create :user
    login_as(user, :scope => :user, :run_callbacks => true)
    user
  end

end