require 'spec_helper'

describe "AdminProfiles" do
  it "EDIT" do
    create_current_admin
    get edit_a_admin_profile_path
    response.status.should be(200)
  end
end
