class Inquiry < ApplicationRecord

  enum subject: { system_issue: 0, malicious_user: 1, activate_account: 2, destroy_account_data: 3, other: 4 }

  with_options presence: true do
    validates :name
    validates :email
    validates :phone_number
    validates :subject
    validates :body
  end

end
