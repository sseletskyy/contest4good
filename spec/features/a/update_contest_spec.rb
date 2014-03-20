require 'spec_helper'

feature "Update Contest" do

  background do
    @contest = fg.create(:contest)
  end

  context "when registered as user" do
    background do
      @user = create_current_user
    end

    scenario 'edit form is not available' do
      visit edit_a_contest_path(@contest)
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
      current_path.should == new_admin_session_path
    end
  end

  context "when registered as admin" do
    background do
      @admin = create_current_admin
      @committee_vice = fg.create(:committee_vice)
      @jury_judge = fg.create(:jury_judge)
      @jury_judge_2 = fg.create(:jury_judge)

    end
    context "when admin has role admin" do
      background do
        @admin.add_role Contest4good::ROLE_ADMIN
        visit edit_a_contest_path(@contest)
      end

      scenario "edit form is available" do
        current_path.should == edit_a_contest_path(@contest)
      end

      context "check for fields in the form" do
        scenario 'all elements should be available' do
          %w(name starts_at ends_at regulations committee_head_ids jury_head_ids committee_vice_ids jury_judge_ids).each do |field|
            expect { find_field("contest_#{field}") }.to be_true
          end
        end
      end

      context "validate required field" do
        scenario "name" do
          fill_name('')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_committee_vice(@committee_vice)
          fill_jury_judge(@jury_judge)

          submit
          current_path.should == a_contest_path(@contest)
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "regulations" do
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('')
          fill_committee_vice(@committee_vice)
          fill_jury_judge(@jury_judge)

          submit
          current_path.should == a_contest_path(@contest)
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "committee_vice is required if it was set before" do
          @committee_vice.add_role Contest4good::ROLE_COMMITTEE_VICE, @contest
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_jury_judge(@jury_judge)
          submit
          current_path.should == a_contest_path(@contest)
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "committee_vice is not required if it wasn't set before" do
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_jury_judge(@jury_judge)
          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('a.contests.notices.create')
        end

        scenario "jury_judge is required if it was set before" do
          @jury_judge.add_role Contest4good::ROLE_JURY_JUDGE, @contest
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_committee_vice(@committee_vice)

          submit
          current_path.should == a_contest_path(@contest)
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "jury_judge is not required if it was not set before" do
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_committee_vice(@committee_vice)

          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('a.contests.notices.create')
        end
      end

      context "contest" do
        background do
          #save_and_open_page
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_jury_judge(@jury_judge)
          fill_committee_vice(@committee_vice)
          submit
          #save_and_open_page
        end

        scenario 'should be updated' do
          expect(page).to have_content I18n.t('a.contests.notices.create')
          current_path.should == a_contests_path
        end

        scenario 'email should be sent to committee_vice' do
          emails_to_test = [
              {email: @committee_vice.email, role: Contest4good::ROLE_COMMITTEE_VICE},
              {email: @jury_judge.email, role: Contest4good::ROLE_JURY_JUDGE}
          ]

          emails_to_test.each do |item|
            puts "\t~ Checking email #{item[:email]} and role #{item[:role]}"
            email = open_email(item[:email])
            mail_body = email.body.encoded
            #puts mail_body
            expect(mail_body).to have_content I18n.t('mailer.contest.invite_mail_subject')
            translated_role = I18n.t(item[:role], scope: 'simple_form.options.admin.roles')
            your_role_is_html = ActionView::Base.full_sanitizer.sanitize(I18n.t('mailer.contest.your_role_is_html', role: translated_role, contest: Contest.last.name))
            expect(mail_body).to have_content your_role_is_html
          end
        end
      end
    end

    context "when admin has role committee_head" do
      background do
        @admin.add_role Contest4good::ROLE_COMMITTEE_HEAD, @contest
        visit edit_a_contest_path(@contest)
      end
      scenario "edit form is available" do
        current_path.should == edit_a_contest_path(@contest)
      end

      context "check for field in the form is" do
        context 'available' do
          scenario 'committee_vice_ids' do
            expect { find_field("contest_committee_vice_ids") }.to be_true
          end
        end
        context 'NOT available' do
          scenario 'name' do
            expect { find_field("contest_name") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'starts_at' do
            expect { find_field("contest_starts_at") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'ends_at' do
            expect { find_field("contest_ends_at") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'regulations' do
            expect { find_field("contest_regulations") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'committee_head_ids' do
            expect { find_field("contest_committee_head_ids") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'jury_head_ids' do
            expect { find_field("contest_jury_head_ids") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'jury_judge_ids' do
            expect { find_field("contest_jury_judge_ids") }.to raise_error(Capybara::ElementNotFound)
          end
        end
      end

      context "validate required field" do
        scenario "committee_vice" do
          fill_committee_vice(@committee_vice)
          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('a.contests.notices.create')
        end
      end

      context "contest" do
        background do
          fill_committee_vice(@committee_vice)
          submit
        end

        scenario 'should be updated' do
          expect(page).to have_content I18n.t('a.contests.notices.create')
          current_path.should == a_contests_path
        end

        scenario 'email should be sent to committee_vice' do
          emails_to_test = [
              {email: @committee_vice.email, role: Contest4good::ROLE_COMMITTEE_VICE}
          ]

          emails_to_test.each do |item|
            puts "\t~ Checking email #{item[:email]} and role #{item[:role]}"
            email = open_email(item[:email])
            mail_body = email.body.encoded
            #puts mail_body
            expect(mail_body).to have_content I18n.t('mailer.contest.invite_mail_subject')
            translated_role = I18n.t(item[:role], scope: 'simple_form.options.admin.roles')
            your_role_is_html = ActionView::Base.full_sanitizer.sanitize(I18n.t('mailer.contest.your_role_is_html', role: translated_role, contest: Contest.last.name))
            expect(mail_body).to have_content your_role_is_html
          end
        end
      end
    end

    context "when admin has role committee_vice" do
      background do
        @admin.add_role Contest4good::ROLE_COMMITTEE_VICE, @contest
        visit edit_a_contest_path(@contest)
      end
      scenario "edit form is available" do
        current_path.should == edit_a_contest_path(@contest)
      end

      context "check for field in the form is" do
        context 'available' do
          scenario 'committee_vice_ids' do
            # no fields are available !
            #expect { find_field("contest_committee_vice_ids") }.to be_true
          end
        end
        context 'NOT available' do
          scenario 'name' do
            expect { find_field("contest_name") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'starts_at' do
            expect { find_field("contest_starts_at") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'ends_at' do
            expect { find_field("contest_ends_at") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'regulations' do
            expect { find_field("contest_regulations") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'committee_head_ids' do
            expect { find_field("contest_committee_head_ids") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'committee_vice_ids' do
            expect { find_field("contest_committee_vice_ids") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'jury_head_ids' do
            expect { find_field("contest_jury_head_ids") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'jury_judge_ids' do
            expect { find_field("contest_jury_judge_ids") }.to raise_error(Capybara::ElementNotFound)
          end
        end
      end

      #context "validate required field" do
      #  scenario "committee_vice" do
      #    submit
      #    current_path.should == a_contests_path
      #    expect(page).to have_content I18n.t('a.contests.notices.create')
      #  end
      #end

      #context "contest" do
      #  background do
      #    submit
      #  end
      #
      #  scenario 'should be updated' do
      #    expect(page).to have_content I18n.t('a.contests.notices.create')
      #    current_path.should == a_contests_path
      #  end
      #
      #  scenario 'email should be sent to committee_vice' do
      #    emails_to_test = [
      #        {email: @committee_vice.email, role: Contest4good::ROLE_COMMITTEE_VICE}
      #    ]
      #
      #    emails_to_test.each do |item|
      #      puts "\t~ Checking email #{item[:email]} and role #{item[:role]}"
      #      email = open_email(item[:email])
      #      mail_body = email.body.encoded
      #      #puts mail_body
      #      expect(mail_body).to have_content I18n.t('mailer.contest.invite_mail_subject')
      #      translated_role = I18n.t(item[:role], scope: 'simple_form.options.admin.roles')
      #      your_role_is_html = ActionView::Base.full_sanitizer.sanitize(I18n.t('mailer.contest.your_role_is_html', role: translated_role, contest: Contest.last.name))
      #      expect(mail_body).to have_content your_role_is_html
      #    end
      #  end
      #end
    end

    context "when admin has role jury_head" do
      background do
        #ActionMailer::Base.deliveries = []
        @admin.add_role Contest4good::ROLE_JURY_HEAD, @contest
        visit edit_a_contest_path(@contest)
      end
      scenario "edit form is available" do
        current_path.should == edit_a_contest_path(@contest)
      end

      context "check for field in the form is" do
        context 'available' do
          scenario 'jury_judge_ids' do
            expect { find_field("contest_jury_judge_ids") }.to be_true
          end
        end
        context 'NOT available' do
          scenario 'name' do
            expect { find_field("contest_name") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'starts_at' do
            expect { find_field("contest_starts_at") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'ends_at' do
            expect { find_field("contest_ends_at") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'regulations' do
            expect { find_field("contest_regulations") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'committee_head_ids' do
            expect { find_field("contest_committee_head_ids") }.to raise_error(Capybara::ElementNotFound)
          end
          scenario 'jury_head_ids' do
            expect { find_field("contest_jury_head_ids") }.to raise_error(Capybara::ElementNotFound)
          end
        end
      end

      context "validate required field" do
        scenario "jury_judge is required if it was set before" do
          @jury_judge.add_role Contest4good::ROLE_JURY_JUDGE, @contest
          submit
          current_path.should == a_contest_path(@contest)
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "jury_judge is not required if it was not set before" do
          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('a.contests.notices.create')
        end
      end

      context "contest" do
        background do
          fill_jury_judge(@jury_judge)
          fill_jury_judge(@jury_judge_2)
          submit
        end

        scenario 'should be updated' do
          expect(page).to have_content I18n.t('a.contests.notices.create')
          current_path.should == a_contests_path
        end

        scenario 'email should be sent to jury_judge and jury_judge_2' do
          emails_to_test = [
              {email: @jury_judge.email, role: Contest4good::ROLE_JURY_JUDGE},
              {email: @jury_judge_2.email, role: Contest4good::ROLE_JURY_JUDGE}
          ]

          emails_to_test.each do |item|
            puts "\t~ Checking email #{item[:email]} and role #{item[:role]}"
            email = open_email(item[:email])
            mail_body = email.body.encoded
            #puts mail_body
            expect(mail_body).to have_content I18n.t('mailer.contest.invite_mail_subject')
            translated_role = I18n.t(item[:role], scope: 'simple_form.options.admin.roles')
            your_role_is_html = ActionView::Base.full_sanitizer.sanitize(I18n.t('mailer.contest.your_role_is_html', role: translated_role, contest: Contest.last.name))
            expect(mail_body).to have_content your_role_is_html
          end
        end
      end
    end

  end


  def submit
    click_on I18n.t('helpers.submit.update', model: I18n.t('activerecord.models.contest'))
  end

  def fill_name(value='')
    fill_in I18n.t("simple_form.labels.contest.name"), with: value
  end

  def fill_regulations(value='')
    fill_in I18n.t("simple_form.labels.contest.regulations"), with: value
  end

  def fill_correct_dates
    select("2014", from: "contest_starts_at_1i")
    select(I18n.t("date.month_names")[4], from: "contest_starts_at_2i")
    select("15", from: "contest_starts_at_3i")
    select("09", from: "contest_starts_at_4i")
    select("00", from: "contest_starts_at_5i")

    select("2014", from: "contest_ends_at_1i")
    select(I18n.t("date.month_names")[4], from: "contest_ends_at_2i")
    select("15", from: "contest_ends_at_3i")
    select("20", from: "contest_ends_at_4i")
    select("00", from: "contest_ends_at_5i")
  end

  def fill_committee_head(admin)
    select(admin.admin_profile.full_name, from: "contest_committee_head_ids")
  end

  def fill_jury_head(admin)
    select(admin.admin_profile.full_name, from: "contest_jury_head_ids")
  end

  def fill_committee_vice(admin)
    select(admin.admin_profile.full_name, from: "contest_committee_vice_ids")
  end

  def fill_jury_judge(admin)
    #unselect("", from: "contest_jury_judge_ids", exact: false)
    select(admin.admin_profile.full_name, from: "contest_jury_judge_ids", exact: false)
  end
end
