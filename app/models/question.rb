class Question < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :answer1, presence: true
  validates :answer2, presence: true
  validates :answer3, presence: true
  validates :answer4, presence: true
  validates :answer, presence: true
  validates :order, presence: true, uniqueness: { scope: :section_id }
  validates :section_id, presence: true
  validates :pre_enrolment_test_id, presence: true

  belongs_to :pre_enrolment_test
  belongs_to :section
  belongs_to :video
end
