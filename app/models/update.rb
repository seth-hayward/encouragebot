class Update < ActiveRecord::Base
  attr_accessible :value
  belongs_to :goal

  validates :goal_id, presence: true
end
