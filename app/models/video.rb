class Video < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: { scope: :section_id }

  belongs_to :pre_enrolment_test
  belongs_to :section
end
