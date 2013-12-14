class Section < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :pre_enrolment_test_id, presence: true
  validates :order, presence: true, uniqueness: { scope: :pre_enrolment_test_id }

  belongs_to :pre_enrolment_test

  has_many :questions, dependent: :destroy
end
