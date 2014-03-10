require 'spec_helper'

describe "Contest", :type => :feature do

  before :each do
    @admin = create_current_admin
  end

  it "should access login page and sign in" do
    visit a_home_path
    click_on I18n.t('a.home.index.create_contest')
    current_path.should == new_a_contest_path

    ### set form
    fill_in I18n.t("simple_form.labels.contest.name"), with: ''
    select("15", from: "contest_starts_at_3i")
    select(I18n.t("date.month_names")[4], from: "contest_starts_at_2i")
    select("2014", from: "contest_starts_at_1i")
    select("09", from: "contest_starts_at_4i")
    select("00", from: "contest_starts_at_5i")

    select("15", from: "contest_ends_at_3i")
    select(I18n.t("date.month_names")[4], from: "contest_ends_at_2i")
    select("2014", from: "contest_ends_at_1i")
    select("20", from: "contest_ends_at_4i")
    select("00", from: "contest_ends_at_5i")

    click_on I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.contest'))
    current_path.should == a_contests_path
    expect(page).to have_content I18n.t('errors.messages.blank')

    ### set name and regulations
    fill_in I18n.t("simple_form.labels.contest.name"), with: 'Математика'
    fill_in I18n.t("simple_form.labels.contest.regulations"), with: 'Положение...'

    click_on I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.contest'))
    current_path.should == a_contest_path(Contest.last)
    expect(page).to have_content I18n.t('a.contests.notices.create')
    save_and_open_page
  end


end
