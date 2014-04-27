object @video
attributes :id, :name, :order, :show_questions, :section_id

child :section do
  attributes :name
end
