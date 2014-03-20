module A::ContestsHelper
  # chooses correct form template according to admin rights
  def contest_edit_form_name(contest)
    if current_admin.has_role? Contest4good::ROLE_ADMIN
      return 'form_for_admin'
    end

    if current_admin.has_role? Contest4good::ROLE_COMMITTEE_HEAD, contest
      return 'form_for_committee_head'
    end

    if current_admin.has_role? Contest4good::ROLE_COMMITTEE_VICE, contest
      return 'form_for_committee_vice'
    end

    if current_admin.has_role? Contest4good::ROLE_JURY_HEAD, contest
      return 'form_for_jury_head'
    end

  end
end
