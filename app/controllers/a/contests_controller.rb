class A::ContestsController < A::ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

  # GET a/contests
  # GET a/contests.json
  def index
    @contests = Contest.all
  end

  # GET a/contests/1
  # GET a/contests/1.json
  def show
  end

  # GET a/contests/new
  def new
    @contest = Contest.new
    set_data_for_new_form
  end

  # GET a/contests/1/edit
  def edit
  end

  # POST a/contests
  # POST a/contests.json
  def create
    @contest = Contest.new(contest_params)
    respond_to do |format|
      if @contest.save
        send_notifications_on_create
        format.html { redirect_to a_contest_url(@contest), notice: I18n.t('a.contests.notices.create') }
        format.json { render action: 'show', status: :created, location: @contest }
      else
        set_data_for_new_form
        format.html { render action: 'new' }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT a/contests/1
  # PATCH/PUT a/contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to a_contest_url(@contest), notice: I18n.t('a.contests.notices.create') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  #def destroy
  #  @contest.destroy
  #  respond_to do |format|
  #    format.html { redirect_to a_contests_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contest
    @contest = Contest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contest_params
    params.require(:contest).permit(:name, :starts_at, :ends_at, :regulations, :committee_head_ids, :jury_head_ids)
  end

  def set_data_for_new_form
    @admins = Admin.all
  end

  def send_notifications_on_create
    admins = Admin.where(id: @contest.committee_head_ids)
    admins.each do |admin|
      A::ContestMailer.send_ticket(@contest, admin, Contest4good::ROLE_COMMITTEE_HEAD).deliver
    end

    admins = Admin.where(id: @contest.jury_head_ids)
    admins.each do |admin|
      A::ContestMailer.send_ticket(@contest, admin, Contest4good::ROLE_JURY_HEAD).deliver
    end

  end
end
