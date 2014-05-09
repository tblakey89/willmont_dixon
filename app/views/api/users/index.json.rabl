object false
node(:success) { true }
child :data do
   node(:users_count) { @users.length }
   child @users do
      attributes :id, :first_name, :last_name, :email, :role, :job, :health_issues, :is_supervisor, :cscs_number, :cscs_expiry_date, :date_of_birth, :national_insurance, :completed_pre_enrolment, :contact_number, :address_line_1, :address_line_2, :city, :postcode, :pre_enrolment_due
   end
end
