class A::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  before_filter :authenticate_admin!
  layout "a/application"

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :roles => []) }
  end
end
