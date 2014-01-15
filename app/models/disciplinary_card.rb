class DisciplinaryCard < ActiveRecord::Base
  validates :location, presence: true
  validates :reason, presence: true
  validates :colour, presence: true, format: { with: /Green|Yellow|Red/ }

  belongs_to :user
end
