class U::UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]

  # GET /u/user_profiles
  # GET /u/user_profiles.json
  def index
    @user_profiles = UserProfile.all
  end

  # GET /u/user_profiles/1
  # GET /u/user_profiles/1.json
  def show
  end

  # GET /u/user_profiles/new
  def new
    @user_profile = UserProfile.new
  end

  # GET /u/user_profiles/1/edit
  def edit
  end

  # POST /u/user_profiles
  # POST /u/user_profiles.json
  def create
    @user_profile = UserProfile.new(user_profile_params)

    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to u_user_profile_path(@user_profile), notice: 'User profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /u/user_profiles/1
  # PATCH/PUT /u/user_profiles/1.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to u_user_profile_path(@user_profile), notice: 'User profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /u/user_profiles/1
  # DELETE /u/user_profiles/1.json
  def destroy
    @user_profile.destroy
    respond_to do |format|
      format.html { redirect_to u_user_profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_profile_params
      params.require(:user_profile).permit(:user_id, :first_name, :middle_name, :last_name, :born_on, :address, :school, :grade, :phone, :parent_name, :parent_phone)
    end
end
