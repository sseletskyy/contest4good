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
    p inv_url

    visit inv_url
    # check user_profile form elements


  end

end
