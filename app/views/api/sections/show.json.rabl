object @section
attributes :id, :name, :order, :work_at_height, :scaffolder, :ground_worker, :operate_machinery, :lift_loads, :young, :supervisor, :total_questions
child(:videos) do
   attributes :id, :order, :show_questions, :name
   child :random_questions do
      attributes :id, :name, :order, :answer1, :answer2, :answer3, :answer4, :answer, :section_id
      node :question_number do |question|
         @section.question_number
      end
   end
end
