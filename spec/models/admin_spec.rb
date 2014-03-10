require 'spec_helper'

describe Admin do
  before(:each) do
    Contest4good::create_roles
    @attr = {
        :name => "Example Admin",
        :email => "admin@example.com",
        :password => "changeme",
        :password_confirmation => "changeme",
        :role_ids => [1]
    }
  end
  describe 'Validation' do
    it 'should not fail to create admin if role_ids is empty' do
      @attr.delete(:role_ids)
      current_admin = Admin.create(@attr)
      current_admin.errors.messages[:role_ids].should be_nil
    end
  end

  describe 'Invite' do
    let(:current_admin_attr) { {
        :email => "current_admin@example.com",
        :password => "changeme",
        :password_confirmation => "changeme",
        :role_ids => [1]
    } }

    it 'admin can be invited without passing current_admin' do
      current_admin = Admin.create!(@attr)
      current_admin.invite!().class.should eq(Mail::Message)
    end

    it 'admin can be invited with passing current_admin' do
      current_admin = Admin.create!(current_admin_attr)
      admin = Admin.create!(@attr)
      admin.invite!(current_admin).class.should eq(Mail::Message)
    end

    it 'invitation should be sent to admin\'s email' do
      admin = Admin.create!(@attr)
      mail = admin.invite!()
      mail.to_addrs.should eq([@attr[:email]])
    end
  end


end
