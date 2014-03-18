class A::ContestMailer < ActionMailer::Base
  helper :application # gives access to all helpers defined within `application_helper`.
  default from: ENV['SYSTEM_EMAIL']
  layout 'mailer'

  def send_ticket(contest, admin, role_name)
    @admin_name = admin.admin_profile.full_name
    @title = I18n.t('mailer.contest.invite_mail_subject')
    @translated_role = I18n.t(role_name, scope: 'simple_form.options.admin.roles')
    @contest_name = contest.name
    mail(to: admin.email, bcc: ENV['ADMIN_EMAIL'], subject: @title)
  end
end
