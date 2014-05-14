object @question
attributes :id, :name, :answer1, :answer2, :answer3, :answer4, :answer, :section_id, :video_id

child :section do
  attributes :name
end

child :video do
   attributes :name
end
