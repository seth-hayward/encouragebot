class Goal < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user
  has_many :updates

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }

  default_scope order: 'goals.created_at DESC'
end
