module Contest4good
  ROLE_ADMIN = 'admin'.freeze                     # administrator
  ROLE_COMMITTEE_HEAD = 'committee_head'.freeze   # glava org. komiteta
  ROLE_COMMITTEE_VICE = 'committee_vice'.freeze   # zam glavy org. komiteta

  ROLE_JURY_HEAD = 'jury_head'.freeze   # glava juri
  ROLE_JURY_JUDGE = 'jury_judge'.freeze # chlen juri

  #ROLE_USER = 'user'.freeze             # uchastnik olimpiady

  ROLES = [ROLE_ADMIN, ROLE_COMMITTEE_HEAD, ROLE_COMMITTEE_VICE, ROLE_JURY_HEAD, ROLE_JURY_JUDGE].freeze

end