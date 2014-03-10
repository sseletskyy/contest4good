class A::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(admin)
    a_home_path
  end
end
