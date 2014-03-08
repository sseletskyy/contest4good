require 'spec_helper'

describe "User Registration", :type => :feature do
  before :each do
    @wrong_email = 'wrong_email'
    @correct_email = 'correct_emai.l@ab.ua'
  end

  it "can access registration" do
    visit root_path
    click_link "Регистрация"
    click_on I18n.t("devise.invitations.new.submit_button")
    expect(page).to have_content I18n.t("activerecord.errors.models.user.attributes.email.blank")

    fill_in I18n.t("activerecord.attributes.user.email"), with: @wrong_email
    click_on I18n.t("devise.invitations.new.submit_button")
    expect(page).to have_content I18n.t("activerecord.errors.models.user.attributes.email.invalid")

    fill_in I18n.t("activerecord.attributes.user.email"), with: @correct_email
    click_on I18n.t("devise.invitations.new.submit_button")
    expect(page).to have_content I18n.t("devise.invitations.send_instructions", email: @correct_email)

    User.find_by(email: @correct_email).should be_true
    last_email_sent.to.should include(@correct_email)

    inv_url = Capybara.string(last_email_sent.body.encoded).first("a")[:href]

    visit inv_url
    #####
    # check user_profile form elements

    ### set password and confirmation only
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    # check and return to form
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_no_content I18n.t('devise.invitations.updated')
    current_path.should == user_invitation_path

    ### set all except terms
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    fill_in I18n.t("simple_form.labels.user_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.user_profile.middle_name"), with: 'Иванович'
    fill_in I18n.t("simple_form.labels.user_profile.last_name"), with: 'Шевченко'
    fill_in I18n.t("simple_form.labels.user_profile.address"), with: 'Гагарина, 8'

    # set "01-03-1995"
    select("1", from: "user_user_profile_attributes_born_on_3i")
    select(I18n.t("date.month_names")[3], from: "user_user_profile_attributes_born_on_2i")
    select("1995", from: "user_user_profile_attributes_born_on_1i")

    fill_in I18n.t("simple_form.labels.user_profile.grade"), with: '5Б'
    fill_in I18n.t("simple_form.labels.user_profile.parent_name"), with: 'Раиса Петровна'
    fill_in I18n.t("simple_form.labels.user_profile.parent_phone"), with: '322-223'
    fill_in I18n.t("simple_form.labels.user_profile.phone"), with: '777-00-33'
    fill_in I18n.t("simple_form.labels.user_profile.school"), with: '№23'
    #check(I18n.t("simple_form.labels.user_profile.terms"))

    # check terms are not aceepted
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_content I18n.t('errors.messages.accept_terms')
    current_path.should == user_invitation_path


    ### set all except confirmation password
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    #fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    fill_in I18n.t("simple_form.labels.user_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.user_profile.middle_name"), with: 'Иванович'
    fill_in I18n.t("simple_form.labels.user_profile.last_name"), with: 'Шевченко'
    fill_in I18n.t("simple_form.labels.user_profile.address"), with: 'Гагарина, 8'

    # set "01-03-1995"
    select("1", from: "user_user_profile_attributes_born_on_3i")
    select(I18n.t("date.month_names")[3], from: "user_user_profile_attributes_born_on_2i")
    select("1995", from: "user_user_profile_attributes_born_on_1i")

    fill_in I18n.t("simple_form.labels.user_profile.grade"), with: '5Б'
    fill_in I18n.t("simple_form.labels.user_profile.parent_name"), with: 'Раиса Петровна'
    fill_in I18n.t("simple_form.labels.user_profile.parent_phone"), with: '322-223'
    fill_in I18n.t("simple_form.labels.user_profile.phone"), with: '777-00-33'
    fill_in I18n.t("simple_form.labels.user_profile.school"), with: '№23'
    check(I18n.t("simple_form.labels.user_profile.terms"))

    # check confirmation password are not aceepted
    click_on I18n.t('devise.invitations.edit.submit_button')
    expect(page).to have_content I18n.t('errors.messages.confirmation', attribute: I18n.t('simple_form.labels.user.password'))
    current_path.should == user_invitation_path


    ### set all
    fill_in I18n.t('simple_form.labels.defaults.password'), with: '123456'
    fill_in I18n.t('simple_form.labels.defaults.password_confirmation'), with: '123456'

    fill_in I18n.t("simple_form.labels.user_profile.first_name"), with: 'Василий'
    fill_in I18n.t("simple_form.labels.user_profile.middle_name"), with: 'Иванович'
    fill_in I18n.t("simple_form.labels.user_profile.last_name"), with: 'Шевченко'
    fill_in I18n.t("simple_form.labels.user_profile.address"), with: 'Гагарина, 8'

    # set "01-03-1995"
    select("1", from: "user_user_profile_attributes_born_on_3i")
    select(I18n.t("date.month_names")[3], from: "user_user_profile_attributes_born_on_2i")
    select("1995", from: "user_user_profile_attributes_born_on_1i")

    fill_in I18n.t("simple_form.labels.user_profile.grade"), with: '5Б'
    fill_in I18n.t("simple_form.labels.user_profile.parent_name"), with: 'Раиса Петровна'
    fill_in I18n.t("simple_form.labels.user_profile.parent_phone"), with: '322-223'
    fill_in I18n.t("simple_form.labels.user_profile.phone"), with: '777-00-33'
    fill_in I18n.t("simple_form.labels.user_profile.school"), with: '№23'
    check(I18n.t("simple_form.labels.user_profile.terms"))

    click_on I18n.t("devise.invitations.edit.submit_button")
    expect(page).to have_content I18n.t('devise.invitations.updated')
    current_path.should == u_home_index_path
    save_and_open_page

  end

end
