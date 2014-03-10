require 'spec_helper'

describe "Admin Profile update", :type => :feature do

  before :each do
    @admin = create_current_admin
  end

  it "can access profile page" do
    visit edit_a_admin_profile_path

    ### set all except last_name
    fill_in I18n.t("simple_form.labels.admin_profile.last_name"), with: ''

    fill_in I18n.t("simple_form.labels.admin_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.admin_profile.middle_name"), with: 'Иванович'

    click_on I18n.t('helpers.submit.submit', model: I18n.t('activerecord.models.admin_profile'))
    #save_and_open_page
    current_path.should == a_admin_profile_path
    expect(page).to have_content I18n.t('errors.messages.blank')

    # set last_name
    fill_in I18n.t("simple_form.labels.admin_profile.last_name"), with: 'Шевченко'

    click_on I18n.t('helpers.submit.submit', model: I18n.t('activerecord.models.admin_profile'))
    #save_and_open_page
    current_path.should == a_home_path
    expect(page).to have_content I18n.t('a.admin_profiles.notices.update')

  end

end
