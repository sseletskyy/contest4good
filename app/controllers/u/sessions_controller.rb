class U::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(user)
    u_home_path
  end
end
