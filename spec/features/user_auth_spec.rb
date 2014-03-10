require 'spec_helper'

describe "User", :type => :feature do

  let(:user) { fg.create(:user) }

  it "should access login page and sign in" do
    visit root_path
    click_on I18n.t('menu.sign_in')
    ### set email and invalid password
    fill_in I18n.t("simple_form.labels.user.email"), with: user.email
    fill_in I18n.t("simple_form.labels.user.password"), with: user.password + '123'

    click_on I18n.t('users.sessions.new.submit')
    current_path.should == new_user_session_path
    expect(page).to have_content I18n.t('devise.failure.invalid')

    ### set valid password
    fill_in I18n.t("simple_form.labels.user.password"), with: user.password
    #save_and_open_page

    click_on I18n.t('users.sessions.new.submit')
    #save_and_open_page
    current_path.should == u_home_path
    expect(page).to have_content I18n.t('devise.sessions.user.signed_in')
  end

  it 'should log out from home page' do
    user = create_current_user

    visit u_home_path
    click_on I18n.t('menu.sign_out')
    current_path.should == root_path
    expect(page).to have_content I18n.t('devise.sessions.user.signed_out')
    #save_and_open_page
  end

  it 'should not have access to u_home if not authorized' do
    visit u_home_path
    current_path.should == new_user_session_path
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  it 'should have access to root if not authorized' do
    visit root_path
    current_path.should == root_path
    expect(page).to have_no_content I18n.t('devise.failure.user.unauthenticated')
  end


end
