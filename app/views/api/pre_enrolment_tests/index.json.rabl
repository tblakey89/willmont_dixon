object false
child @users => :users do
   attributes :id, :first_name, :last_name, :email
   node :employer do |user|
      user.employers.first.company_name if user.employers.first
   end
   node :overdue do |user|
      ((((DateTime.now.to_time - user.pre_enrolment_due.to_time) / 60).round / 60).round / 24).round
   end
end
node :red_cards do
   DisciplinaryCard.where("colour = 'Red'").count
end
node :yellow_cards do
   DisciplinaryCard.where("colour = 'Yellow'").count
end
node :green_cards do
   DisciplinaryCard.where("colour = 'Green'").count
end
node :user_count do
   User.where("role = 1").count
end
child @expired => :expireds do
   attributes :id, :first_name, :last_name, :email
   node :employer do |user|
      user.employers.first.company_name if user.employers.first
   end
   node :overdue do |user|
      ((((DateTime.now.to_time - user.cscs_expiry_date.to_time) / 60).round / 60).round / 24).round
   end
end
