class PreEnrolmentTest < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :sections, dependent: :destroy
  has_many :questions, dependent: :destroy
end
