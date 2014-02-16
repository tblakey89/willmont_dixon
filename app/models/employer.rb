class Employer < ActiveRecord::Base
  belongs_to :user

  validates :company_name, presence: true
  validates :address_line_1, presence: true
  validates :postal_code, presence: true, format: { with: /([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})/i }
  validates :contact_number, presence: true, numericality: { only_integer: true, allow_nil: true }
end
