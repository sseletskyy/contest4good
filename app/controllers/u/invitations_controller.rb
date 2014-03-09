class U::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/invitation/new
  def new
    self.resource = resource_class.new
    #resource.build_user_profile
    render :new
  end

  def update
    attributes = params[:user]
    original_token = attributes.delete(:invitation_token)
    self.resource = User.find_by_invitation_token(original_token, false)
    if resource.errors.empty?
      resource.build_user_profile(attributes[:user_profile_attributes])
      resource.assign_attributes(attributes)
    end

    if resource.valid? && resource.user_profile.valid?
      begin
        resource.user_profile.save!
        resource.accept_invitation!
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message
        sign_in(resource_name, resource)
        respond_with resource, :location => u_home_path
      rescue
        respond_with_navigational(resource) { render :edit }
      end
    else
      respond_with_navigational(resource) { render :edit }
    end
  end

  def edit
    resource.invitation_token = params[:invitation_token]
    resource.build_user_profile
    render :edit
  end

  protected
  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:user_profile_attributes]
  end

  private
  def resource_params
    params.permit(user: [:name, :email, :invitation_token, :user_profile_attributes])[:user]
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource_class.accept_invitation!(update_resource_params)
    resource
  end

end