class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  validates :first_name, presence: true, on: :update, if: :operative?
  validates :first_name, presence: true, unless: :operative?
  validates :last_name, presence: true, on: :update
  validates :last_name, presence: true, unless: :operative?
  validates :date_of_birth, presence: true, on: :update, if: :operative?
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_nil: true }, on: :update, if: :email?
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_nil: true }, unless: :operative?
  validates :national_insurance, presence: true, uniqueness: { case_insensitive: false, allow_nil: true }, format: { with: /\s*[a-zA-Z]{2}(?:\s*\d\s*){6}[a-zA-Z]?\s*/, allow_nil: true }, if: :operative?
  validates :cscs_number, presence: true, uniqueness: { case_sensitive: false }, if: :operative?
  validates :cscs_expiry_date, presence: true, on: :update, if: :operative?
  validates :role, presence: true, on: :update
  validates :job, presence: true, on: :update, if: :operative?
  validates :postcode, presence: true, format: { with: /([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})/i, allow_nil: true }, if: :operative?, on: :update
  validates :contact_number, presence: true, numericality: { only_integer: true, allow_nil: true }, if: :operative?, on: :update
  validates :uid, uniqueness: { allow_nil: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :token_authenticatable, :validatable

  before_save :ensure_authentication_token

  has_many :next_of_kins, dependent: :destroy
  has_many :disciplinary_cards, dependent: :destroy
  has_many :employers, dependent: :destroy

  after_save :check_uid

  def full_name
    self.first_name + " " + self.last_name if self.first_name && self.last_name
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

  def company_name
    self.employer.company_name if self.employer
  end

  def next_of_kin_id
    self.next_of_kins.first.id unless self.next_of_kins.blank?
  end

  def extension_valid? extension
    p extension
    extension =~ /\.jpg/ || extension =~ /\.png/ || extension =~ /jpeg/ || extension =~ /\.gif/
  end

  def young
    (Time.now - 18.years) < self.date_of_birth if self.date_of_birth
  end

  def cscs_expiry_month
    self.cscs_expiry_date.strftime("%Y-%m") if self.cscs_expiry_date
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["first name", "last name", "role", "job", "cscs number",
        "cscs expiry date","date of birth", "completed pre enrolment",
        "pre enrolment due","health issues","is supervisor","work at height","scaffolder","ground worker",
        "operate machinery","lift loads"]
      all.each do |user|
        csv << [user.first_name, user.last_name,user.role_string,
          user.job,user.cscs_number,user.cscs_expiry_date,user.date_of_birth,
          user.national_insurance,user.completed_pre_enrolment,user.pre_enrolment_due,
          user.health_issues,user.is_supervisor,user.work_at_height,
          user.scaffolder,user.ground_worker,user.operate_machinery,user.lift_loads]
      end
    end
  end

  def self.send_reminder
    users = User.where("pre_enrolment_due < date_trunc('day', NOW() - interval '1 month') and (reminder is null or reminder = false)")
    users.each do |user|
      Reminder.send_reminder(user).deliver
      user.update_attributes(reminder: true)
    end
  end

  def check_uid
    if self.uid.nil?
      self.update_attributes(uid: rand(1000000))
    end
  end

  def update_progress progress
    prev_progress = []
    prev_progress = self.exam_progress.split(",") if self.exam_progress
    prev_progress.push(progress) unless prev_progress.include? progress
    self.update_attributes exam_progress: prev_progress.join(",")
  end

  def email_required?
    false
  end

  def password_required?
    if self.role == 1 && self.id.nil?
      false
    else
      super
    end
  end
end

