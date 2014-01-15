object @disciplinary_card
attributes :id, :location, :reason, :colour

child :user do
  attributes :first_name, :last_name, :id
end
