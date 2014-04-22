object @disciplinary_card
attributes :id, :location, :reason, :colour, :created_at

child :user do
  attributes :first_name, :last_name, :id
end
