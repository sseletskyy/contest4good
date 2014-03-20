class A::InvitationsController < Devise::InvitationsController
  layout "a/application"
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # GET /a/invitation/new
  def new
    self.resource = resource_class.new
    render :new
  end

  #def create
  #  puts "----"
  #  attributes = params[:admin] #invite_params
  #  #puts params[:admin].inspect
  #  #puts attributes.inspect
  #  self.resource = Admin.new(attributes)
  #  if resource.save
  #    resource.invite!(current_inviter)
  #    set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
  #    respond_with resource, :location => after_invite_path_for(resource)
  #  else
  #    respond_with_navigational(resource) { render :new }
  #  end
  #end

  def update
    attributes = params[:admin] #update_resource_params
    original_token = attributes.delete(:invitation_token)
    self.resource = Admin.find_by_invitation_token(original_token, false)
    if resource.errors.empty?
      resource.build_admin_profile(attributes[:admin_profile_attributes])
      resource.assign_attributes(attributes)
    end

    if resource.valid? && resource.admin_profile.valid?
      begin
        resource.admin_profile.save!
        resource.accept_invitation!
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message
        sign_in(resource_name, resource)
        respond_with resource, :location => a_home_path
      rescue
        respond_with_navigational(resource) { render :edit }
      end
    else
      respond_with_navigational(resource) { render :edit }
    end
  end

  def edit
    resource.invitation_token = params[:invitation_token]
    resource.build_admin_profile
    render :edit
  end

  protected
  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:admin_profile_attributes]
  end

  private
  def resource_params
    params.permit(admin: [:name, :email, :invitation_token, :admin_profile_attributes])[:admin]
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource_class.accept_invitation!(update_resource_params)
    resource
  end

end