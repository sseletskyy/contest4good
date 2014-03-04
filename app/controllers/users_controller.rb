class UsersController < ApplicationController
  before_action :gen_password, only: [:create]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.invite!()
        format.html { redirect_to root_path, notice: I18n.t('users.notices.create') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params[:user]
  end

  def gen_password

    if params[:user][:password].blank?
      params[:user][:password]=params[:user][:password_confirmation]= Array.new(6) { [*'0'..'9', *'A'..'Z', *'a'..'z'].sample }.join
    end
  end

end
