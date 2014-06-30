class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :date_of_birth, presence: true, on: :update, if: :operative?
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_nil: true }, uniqueness: { case_insensitive: false, allow_nil: true }, on: :update
  validates :national_insurance, presence: true, uniqueness: { case_insensitive: false, allow_nil: true }, format: { with: /\s*[a-zA-Z]{2}(?:\s*\d\s*){6}[a-zA-Z]?\s*/, allow_nil: true }, if: :operative?, on: :update
  validates :cscs_number, uniqueness: { allow_nil: true  }, if: :operative?
  validates :cscs_expiry_date, presence: true, on: :update, if: :operative?
  validates :role, presence: true, on: :update
  validates :job, presence: true, on: :update, if: :operative?
  validates :postcode, presence: true, format: { with: /([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})/i, allow_nil: true }, if: :operative?, on: :update
  validates :contact_number, presence: true, numericality: { only_integer: true, allow_nil: true }, if: :operative?, on: :update

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :token_authenticatable

  before_save :ensure_authentication_token

  has_many :next_of_kins, dependent: :destroy
  has_many :disciplinary_cards, dependent: :destroy
  has_many :employers, dependent: :destroy

  def operative?
    self.role < 2 unless self.role.nil?
  end

  def add_role current_user, role
    if current_user.role > 1
      self.role = role
    end
  end

  def green_cards
    self.cards "Green"
  end

  def yellow_cards
    self.cards "Yellow"
  end

  def red_cards
    self.cards "Red"
  end

  def cards colour
    self.disciplinary_cards.where("colour = '" + colour  + "' and created_at >= (NOW() -  '1 year'::interval)").count
  end

  def employer_id
    self.employers.first.id unless self.employers.blank?
  end

  def next_of_kin_id
    self.next_of_kins.first.id unless self.next_of_kins.blank?
  end

  def extension_valid? extension
    extension =~ /\.jpg/ || extension =~ /\.png/ || extension =~ /\.jpeg/ || extension =~ /\.gif/
  end

  def young
    (Time.now - 18.years) < self.date_of_birth if self.date_of_birth
  end

  def cscs_expiry_month
    self.cscs_expiry_date.strftime("%Y-%m")
  end
end

