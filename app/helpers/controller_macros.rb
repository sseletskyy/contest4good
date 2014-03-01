module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @current_user = FactoryGirl.create(:user)
      sign_in @current_user # Using factory girl as an example

    end
  end

  def login_admin_in_tenant
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:user_in_tenant) # Using factory girl as an example
    end
  end

  def login_user_in_tenant
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user_in_tenant)
      user.accept_invitation! #
      sign_in user
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:user)
      @current_user.accept_invitation! #
      sign_in @current_user
    end
  end


end