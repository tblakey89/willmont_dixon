class Password < ActiveRecord::Base
  validates :password, presence: true, uniqueness: true
end
