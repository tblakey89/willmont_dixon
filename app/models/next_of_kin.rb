class NextOfKin < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :relationship, presence: true
  validates :address_line_1, presence: true
  validates :postcode, presence: true, format: { with: /([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})/i }
end
