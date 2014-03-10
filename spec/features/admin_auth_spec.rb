require 'spec_helper'

describe "Admin", :type => :feature do

  let(:admin) { fg.create(:admin) }

  it "should access login page and sign in" do
    Contest4good::create_roles
    #visit a_home_path
    visit root_path
    click_on I18n.t('menu.admin_sign_in')
    ### set email and invalid password
    fill_in I18n.t("simple_form.labels.admin.email"), with: admin.email
    fill_in I18n.t("simple_form.labels.admin.password"), with: admin.password + '123'

    click_on I18n.t('admins.sessions.new.submit')
    current_path.should == new_admin_session_path
    expect(page).to have_content I18n.t('devise.failure.invalid')

    ### set valid password
    fill_in I18n.t("simple_form.labels.admin.password"), with: admin.password
    #save_and_open_page

    click_on I18n.t('admins.sessions.new.submit')
    #save_and_open_page
    current_path.should == a_home_path
    expect(page).to have_content I18n.t('devise.sessions.admin.signed_in')
  end

  it 'should log out from home page' do
    admin = create_current_admin

    visit a_home_path
    click_on I18n.t('menu.sign_out')
    current_path.should == root_path
    expect(page).to have_content I18n.t('devise.sessions.admin.signed_out')
    #save_and_open_page
  end

  it 'should not have access to a_home if not authorized' do
    visit a_home_path
    current_path.should == new_admin_session_path
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  it 'should have access to root if not authorized' do
    visit root_path
    current_path.should == root_path
    expect(page).to have_no_content I18n.t('devise.failure.admin.unauthenticated')
  end


end
