require 'spec_helper'

describe "UserProfiles" do
  it "EDIT" do
    create_current_user
    get edit_u_user_profile_path
    response.status.should be(200)
  end
end
