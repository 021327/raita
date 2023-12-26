class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  GENDERS = ['Mens', 'Womens']  # 選択肢の定義
  
  validates :gender, inclusion: { in: GENDERS, message: "must be one of #{GENDERS.join(', ')}" }
  
  validates :age, presence: true, numericality: { only_integer: true }, length: { maximum: 2 }
  
  has_secure_password
  
  has_many :participants
  has_many :events, through: :participants
  
  
  def participant(event)
    self.participans.find_or_create_by(event_id: event.id)
  end

  def unparticipant(event)
    participant = self.participants.find_by(event_id: event.id)
    participant.destroy if participant
  end

  def participanted?(event)
    self.participants.include?(event)
  end
end