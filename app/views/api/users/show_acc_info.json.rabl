object @user
attributes :id, :authentication_token, :first_name, :last_name, :email, :job, :health_issues, :is_supervisor, :cscs_number, :cscs_expiry_date, :date_of_birth, :national_insurance, :completed_pre_enrolment, :pre_enrolment_due, :profile
child (:employers) do
   attributes :company_name, :contact_number, :address_line_1, :address_line_2, :city, :postal_code
end
node :red_card_count do |user|
   user.red_cards > 0
end
node :cscs_expired do |user|
   true if user.cscs_expiry_date.nil? || !user.cscs_expiry_date.nil? && user.cscs_expiry_date < DateTime.now
end
node :enrolment_expired do |user|
   true if user.pre_enrolment_due.nil? || !user.pre_enrolment_due.nil? && user.pre_enrolment_due < DateTime.now
end
