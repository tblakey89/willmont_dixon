class Section < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :pre_enrolment_test_id, presence: true
  validates :order, presence: true, uniqueness: { scope: :pre_enrolment_test_id }

  belongs_to :pre_enrolment_test

  has_many :videos, dependent: :destroy
  has_many :questions, dependent: :destroy

  def correct? answers
    correct = true
    answers.each { |question, answer| correct = false unless Question.find(question).answer == answer }
    correct
  rescue
    false
  end

  def question_number
    if @number.nil?
      @number = 1
    else
      @number += 1
    end
  end

  def total_questions
    self.videos.sum(:show_questions)
  end

  def correct_answers answers
    correct_answer = []
    answers.each { |question, answer| correct_answer << { id: question, answer: Question.find(question).answer } }
    correct_answer
  end

end
