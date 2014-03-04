class Video < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: { scope: :section_id }
  validates :show_questions, presence: true

  belongs_to :pre_enrolment_test
  belongs_to :section

  has_many :questions

  def extension_valid? extension
    extension =~ /\.mp4/
  end

  def random_questions
    self.questions.order('random()').limit(self.show_questions)
  end
end
