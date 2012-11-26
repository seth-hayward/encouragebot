class Update < ActiveRecord::Base
  attr_accessible :value, :notes
  belongs_to :goal

  validates :goal_id, presence: true
  validates_numericality_of :value

  default_scope order: 'updates.created_at DESC'
end
