class Video < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: { scope: :section_id }

  belongs_to :pre_enrolment_test
  belongs_to :section

  def extension_valid? extension
    extension =~ /\.mp4/
  end
end
