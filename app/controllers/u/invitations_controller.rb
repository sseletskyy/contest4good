class U::InvitationsController < Devise::InvitationsController
  def update
    self.resource = accept_resource

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource) { render :edit }
    end
  end

  def edit
    resource.invitation_token = params[:invitation_token]
    resource.build_user_profile
    render :edit
  end

  private
  # TODO !!!
  #def resource_params
  #  params.permit(user: [:name, :email, :invitation_token, :user_params_attributes])[:user]
  #end
end