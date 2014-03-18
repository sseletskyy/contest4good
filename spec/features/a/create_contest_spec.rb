require 'spec_helper'

feature "Contest" do

  context "when registered as user" do
    background do
      @user = create_current_user
    end

    scenario 'new form is not available' do
      visit new_a_contest_path
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
      current_path.should == new_admin_session_path
    end
  end

  context "when registered as admin" do
    background do
      @admin = create_current_admin
      @committee = fg.create(:committee_head)
      @jury = fg.create(:jury_head)
    end
    context "when admin has role admin" do
      background do
        @admin.add_role Contest4good::ROLE_ADMIN
      end

      context "new form is available" do
        background do
          visit a_home_path
          click_on I18n.t('a.home.index.create_contest')
        end

        scenario "from home_path" do
          current_path.should == new_a_contest_path
        end
      end

      context "validate required field" do
        background do
          visit new_a_contest_path
        end

        scenario "name" do
          fill_name('')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_committee_head(@committee)
          fill_jury_head(@jury)

          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "regulations" do
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('')
          fill_committee_head(@committee)
          fill_jury_head(@jury)

          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "committee_head" do
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_jury_head(@jury)
          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('errors.messages.blank')
        end

        scenario "jury_head" do
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_committee_head(@committee)

          submit
          current_path.should == a_contests_path
          expect(page).to have_content I18n.t('errors.messages.blank')
        end
      end

      context "contest" do
        background do
          visit new_a_contest_path
          fill_name('contest name')
          fill_correct_dates
          fill_regulations('regulation text')
          fill_committee_head(@committee)
          fill_jury_head(@jury)
          submit
        end

        scenario 'should be created' do
          expect(page).to have_content I18n.t('a.contests.notices.create')
          current_path.should == a_contest_path(Contest.last)
        end

        scenario 'email should be sent to committee_head' do
          emails_to_test = [
              {email: @committee.email, role: Contest4good::ROLE_COMMITTEE_HEAD},
              {email: @jury.email, role: Contest4good::ROLE_JURY_HEAD}
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

end

def submit
  click_on I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.contest'))
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

def fill_committee_head(committee)
  select(committee.admin_profile.full_name, from: "contest_committee_head_ids")
end

def fill_jury_head(jury)
  select(jury.admin_profile.full_name, from: "contest_jury_head_ids")
end