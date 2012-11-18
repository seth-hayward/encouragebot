class Goal < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user

  validates :user_id, presence: true

  default_scope order: 'goals.created_at DESC'
end
