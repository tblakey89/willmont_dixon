class DisciplinaryCard < ActiveRecord::Base
  validates :location, presence: true
  validates :reason, presence: true
  validates :colour, presence: true, format: { with: /Green|Yellow|Red/ }

  belongs_to :user

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["user", "company", "colour", "location", "assigned"]
      all.each do |disciplinary_card|
        array = []
        array << disciplinary_card.user.full_name
        array << (!disciplinary_card.user.employer.nil? ? disciplinary_card.user.employer.company_name : nil)
        array << disciplinary_card.colour
        array << disciplinary_card.location
        array << disciplinary_card.created_at
        csv << array
      end
    end
  end
end
