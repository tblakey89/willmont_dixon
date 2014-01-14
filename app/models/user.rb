class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_insensitive: false }
  validates :date_of_birth, presence: true
  validates :national_insurance, presence: true, uniqueness: { case_insensitive: false }, format: { with: /\s*[a-zA-Z]{2}(?:\s*\d\s*){6}[a-zA-Z]?\s*/ }
  validates :cscs_number, presence: true, uniqueness: true
  validates :cscs_expiry_date, presence: true
  validates :role, presence: true
  validates :postcode, presence: true, format: { with: /([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})/i }
  validates :contact_number, presence: true, numericality: { only_integer: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :token_authenticatable

  before_save :ensure_authentication_token

  has_many :next_of_kins, dependent: :destroy
end
