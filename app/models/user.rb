class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_insensitive: false }
  validates :date_of_birth, presence: true, if: :operative?
  validates :national_insurance, presence: true, uniqueness: { case_insensitive: false }, format: { with: /\s*[a-zA-Z]{2}(?:\s*\d\s*){6}[a-zA-Z]?\s*/ }, if: :operative?
  validates :cscs_number, presence: true, uniqueness: true, if: :operative?
  validates :cscs_expiry_date, presence: true, if: :operative?
  validates :role, presence: true
  validates :postcode, presence: true, format: { with: /([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})/i }, if: :operative?
  validates :contact_number, presence: true, numericality: { only_integer: true }, if: :operative?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :token_authenticatable

  before_save :ensure_authentication_token

  has_many :next_of_kins, dependent: :destroy
  has_many :disciplinary_cards, dependent: :destroy

  def operative?
    self.role < 2 unless self.role.nil?
  end

  def add_role current_user, role
    if current_user.role > 1
      self.role = role
    end
  end
end
