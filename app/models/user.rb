class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :date_of_birth, presence: true, on: :update, if: :operative?
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_nil: true }, on: :update
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

  def full_name
    self.first_name + " " + self.last_name
  end

  def operative?
    self.role < 2 unless self.role.nil?
  end

  def add_role current_user, role
    if current_user.role > 1
      self.role = role
    end
  end

  def role_string
    case self.role
    when 1
      "Operative"
    when 2
      "Basic Admin"
    when 3
      "Super Admin"
    when 4
      "Director Admin"
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

  def employer
    self.employers.last
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
    self.cscs_expiry_date.strftime("%Y-%m") if self.cscs_expiry_date
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["first name", "last name", "email", "role", "job", "cscs number",
        "cscs expiry date","date of birth", "national insurance", "completed pre enrolment",
        "pre enrolment due","contact number","address line 1","address line 2","city",
        "postcode","health issues","is supervisor","work at height","scaffolder","ground worker",
        "operate machinery","lift loads"]
      all.each do |user|
        csv << [user.first_name, user.last_name, user.email,user.role_string,
          user.job,user.cscs_number,user.cscs_expiry_date,user.date_of_birth,
          user.national_insurance,user.completed_pre_enrolment,user.pre_enrolment_due,
          user.contact_number,user.address_line_1,user.address_line_2,user.city,
          user.postcode,user.health_issues,user.is_supervisor,user.work_at_height,
          user.scaffolder,user.ground_worker,user.operate_machinery,user.lift_loads]
      end
    end
  end

  def self.send_reminder
    users = User.where("pre_enrolment_due < now() and (reminder is null or reminder = false)")
    users.each do |user|
      Reminder.send_reminder(user).deliver
      user.update_attributes(reminder: true)
    end
  end
end

