require 'spec_helper'

describe Role do
  it 'scope general should return two roles' do
    Contest4good::create_roles
    result = Role.general
    result.size.should == 2
    result.map(&:name).should == Contest4good::ROLES_GENERAL
  end
end
