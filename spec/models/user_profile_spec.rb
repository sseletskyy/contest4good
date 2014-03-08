require 'spec_helper'

describe UserProfile do
  it 'should set virtual attribute terms via build_user_profile' do
    user = User.new
    user.build_user_profile
    user.user_profile.terms.should be_nil
    user.build_user_profile({"terms" => "true"})
    user.user_profile.terms.should_not be_nil
  end
end
