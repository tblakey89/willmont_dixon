class NextOfKin < ActiveRecord::Base
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :relationship, presence: true
  validates :contact_number, presence: true, numericality: { only_integer: true, allow_nil: true }
end
