require 'spec_helper'

describe "User Profile update", :type => :feature do

  before :each do
    @user = create_current_user
  end

  it "can access profile page" do
    visit edit_u_user_profile_path

    ### set all except last_name
    fill_in I18n.t("simple_form.labels.user_profile.last_name"), with: ''

    fill_in I18n.t("simple_form.labels.user_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.user_profile.middle_name"), with: 'Иванович'
    fill_in I18n.t("simple_form.labels.user_profile.address"), with: 'Гагарина, 8'

    # set "01-03-1995"
    select("1", from: "user_profile_born_on_3i")
    select(I18n.t("date.month_names")[3], from: "user_profile_born_on_2i")
    select("1995", from: "user_profile_born_on_1i")

    fill_in I18n.t("simple_form.labels.user_profile.grade"), with: '5Б'
    fill_in I18n.t("simple_form.labels.user_profile.parent_name"), with: 'Раиса Петровна'
    fill_in I18n.t("simple_form.labels.user_profile.parent_phone"), with: '322-223'
    fill_in I18n.t("simple_form.labels.user_profile.phone"), with: '777-00-33'
    fill_in I18n.t("simple_form.labels.user_profile.school"), with: '№23'

    click_on I18n.t('helpers.submit.submit', model: I18n.t('activerecord.models.user_profile'))
    #save_and_open_page
    current_path.should == u_user_profile_path
    expect(page).to have_content I18n.t('errors.messages.blank')

    # set last_name
    fill_in I18n.t("simple_form.labels.user_profile.last_name"), with: 'Шевченко'

    click_on I18n.t('helpers.submit.submit', model: I18n.t('activerecord.models.user_profile'))
    #save_and_open_page
    current_path.should == u_home_path
    expect(page).to have_content I18n.t('u.user_profiles.notices.update')

  end

end
