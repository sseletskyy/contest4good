require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
        :name => "Example User",
        :email => "user@example.com",
        :password => "changeme",
        :password_confirmation => "changeme"
    }
  end

  describe 'Invite' do
    let(:current_user_attr) { {
        :email => "current_user@example.com",
        :password => "changeme",
        :password_confirmation => "changeme"
    } }

    it 'user can be invited without passing current_user' do
      current_user = User.create!(@attr)
      current_user.invite!().class.should eq(Mail::Message)
    end

    it 'user can be invited with passing current_user' do
      current_user = User.create!(current_user_attr)
      user = User.create!(@attr)
      user.invite!(current_user).class.should eq(Mail::Message)
    end

    it 'invitation should be sent to user\'s email' do
      user = User.create!(@attr)
      mail = user.invite!()
      mail.to_addrs.should eq([@attr[:email]])
    end
  end
end
