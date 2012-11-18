class Goal < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user

  validates :user_id, presence: true
end
