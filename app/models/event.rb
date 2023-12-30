class Event < ApplicationRecord
  belongs_to :user

  validates :location, presence: true
  validates :deadline_time, presence: true
  validates :date, presence: true
  validates :user, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :mensmax_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :womansmax_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :mensprice, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :womansprice, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :memo, length: { maximum: 255 }
  
  has_many :participants
  has_many :users, through: :participants
  
end
