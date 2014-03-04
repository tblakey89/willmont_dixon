object @video
attributes :id, :name, :order, :show_questions

child :random_questions do
  attributes :id, :name, :order, :answer1, :answer2, :answer3, :answer4, :answer, :section_id
end
