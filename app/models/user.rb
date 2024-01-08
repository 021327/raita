class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  GENDERS = ['Mens', 'Womens']  # 選択肢の定義
  
  validates :gender, inclusion: { in: GENDERS, message: "must be one of #{GENDERS.join(', ')}" }
  
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }, length: { maximum: 2 }
  
  has_secure_password

  has_many :events
  has_many :participants
  has_many :participant_events, through: :participants, source: :event # そのユーザーが参加するイベント一覧
  
  def participant(event)
    self.participants.find_or_create_by(event_id: event.id)
  end

  def unparticipant(event)
    participant = self.participants.find_by(event_id: event.id)
    participant.destroy if participant
  end

  def participanted?(event)
   self.participant_events.include?(event)
  end
  
  def admin?
    # ユーザーの ID が 1 であれば管理者と判定する
    id == 1
  end
end