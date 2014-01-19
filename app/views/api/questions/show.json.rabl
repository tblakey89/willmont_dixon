object @question
attributes :id, :name, :order, :answer1, :answer2, :answer3, :answer4, :answer, :section_id

child :section do
  attributes :name
end
