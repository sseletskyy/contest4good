module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @current_admin = FactoryGirl.create(:admin)
      sign_in @current_admin # Using factory girl as an example

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