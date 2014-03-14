class A::AdminProfilesController < A::ApplicationController
  before_action :set_admin_profile, only: [:show, :edit, :update, :destroy]

  # GET a/contests
  # GET a/contests.json
  def index
    @admin_profiles = AdminProfile.all
  end

  # GET /a/admin_profile
  # GET /a/admin_profile.json
  def show
  end

  # GET /a/admin_profile/edit
  def edit
  end

  # PATCH/PUT /a/admin_profile
  # PATCH/PUT /a/admin_profile.json
  def update
    respond_to do |format|
      if @admin_profile.update(admin_profile_params)
        format.html { redirect_to a_home_path, notice: I18n.t('a.admin_profiles.notices.update') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_profile
      @admin_profile = current_admin.admin_profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_profile_params
      params.require(:admin_profile).permit(:admin_id, :first_name, :middle_name, :last_name, :phone)
    end
end
