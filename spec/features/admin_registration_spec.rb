require 'spec_helper'

describe "Admin Registration", :type => :feature do

  it "can access registration" do
    @wrong_email = 'wrong_email'
    @correct_email = 'correct_emai.l@ab.ua'
    @admin = create_current_admin
    visit a_home_path
    click_link I18n.t('menu.invite')
    click_on I18n.t("devise.invitations.new.submit_button")
    expect(page).to have_content I18n.t("activerecord.errors.models.admin.attributes.email.blank")
    fill_in I18n.t("simple_form.labels.admin.email"), with: @wrong_email
    click_on I18n.t("devise.invitations.new.submit_button")
    expect(page).to have_content I18n.t("activerecord.errors.models.admin.attributes.email.invalid")

    fill_in I18n.t("simple_form.labels.admin.email"), with: @correct_email
    click_on I18n.t("devise.invitations.new.submit_button")
    expect(page).to have_content I18n.t("devise.invitations.send_instructions", email: @correct_email)

    Admin.find_by(email: @correct_email).should be_true
    last_email_sent.to.should include(@correct_email)

    inv_url = Capybara.string(last_email_sent.body.encoded).first("a")[:href]

    visit inv_url
    #####
    # check admin_profile form elements

    ### set password and confirmation only
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    # check and return to form
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_no_content I18n.t('devise.invitations.updated')
    current_path.should == admin_invitation_path

    ### set all except last_name
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    fill_in I18n.t("simple_form.labels.admin_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.admin_profile.middle_name"), with: 'Иванович'
    fill_in I18n.t("simple_form.labels.admin_profile.phone"), with: '777-00-33'

    # check last_name is not aceepted
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_content I18n.t('errors.messages.blank')
    current_path.should == admin_invitation_path


    ### set all except confirmation password
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    #fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    fill_in I18n.t("simple_form.labels.admin_profile.last_name"), with: 'Шевченко'

    # check confirmation password are not aceepted
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_content I18n.t('errors.messages.confirmation', attribute: I18n.t('simple_form.labels.admin.password'))
    current_path.should == admin_invitation_path


    ### set all
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    fill_in I18n.t("simple_form.labels.admin_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.admin_profile.middle_name"), with: 'Иванович'
    fill_in I18n.t("simple_form.labels.admin_profile.last_name"), with: 'Шевченко'
    fill_in I18n.t("simple_form.labels.admin_profile.phone"), with: '777-00-33'

    click_on I18n.t("devise.invitations.edit.submit_button")
    expect(page).to have_content I18n.t('devise.invitations.updated')
    current_path.should == a_home_path
    #save_and_open_page

  end

end
