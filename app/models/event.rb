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
  
  validate :end_time_after_start_time
  validate :deadline_before_event_date

  private

  def end_time_after_start_time
    return unless start_time && end_time

    errors.add(:end_time, 'は開始時間より後の時刻に設定してください') if start_time >= end_time
  end

  def deadline_before_event_date
    return unless date && deadline_time

    errors.add(:deadline_time, 'はイベント開催日より前の時刻に設定してください') if date <= deadline_time.to_date
  end
  
  
  has_many :participants, dependent: :destroy
  # has_many :users, through: :participants　
  has_many :event_participants, through: :participants, source: :user # そのイベントに参加するユーザー一覧
  
end
