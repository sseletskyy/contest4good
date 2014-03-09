class U::UserProfilesController < U::ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]

  # GET /u/user_profile
  # GET /u/user_profile.json
  def show
  end

  # GET /u/user_profile/edit
  def edit
  end

  # PATCH/PUT /u/user_profile
  # PATCH/PUT /u/user_profile.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to u_home_path, notice: I18n.t('u.user_profiles.notices.update') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /u/user_profile
  # DELETE /u/user_profile.json
  #def destroy
  #  @user_profile.destroy
  #  respond_to do |format|
  #    format.html { redirect_to u_user_profiles_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = current_user.user_profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_profile_params
      params.require(:user_profile).permit(:user_id, :first_name, :middle_name, :last_name, :born_on, :address, :school, :grade, :phone, :parent_name, :parent_phone)
    end
end
