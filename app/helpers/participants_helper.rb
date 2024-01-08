module ParticipantsHelper
  
  # イベントの参加できるかをチェックするメソッド
  def can_participate?(event)
    
    # 男女それぞれの定員数
    max_mens_count = event.mensmax_participants
    max_womens_count = event.womansmax_participants
    
    # 現在の男女、それぞれの現在の参加予定者数
    mens_count = event.event_participants.where('gender':  'Mens').count
    womens_count = event.event_participants.where('gender':  'Womens').count
    
    # 申し込み期限
    deadline = event.deadline_time.to_date
    
    # 本日
    today = Date.today
    
    # メソッドの戻り値の初期値
    result = true
    
    # 性別ごとに定員を超えていないかの判定
    if current_user.gender == 'Mens' 
      if mens_count >= max_mens_count
        result = false
      end
    elsif current_user.gender == 'Womens'
      if womens_count >= max_womens_count
       result = false
      end
    end
    
    # 申し込み期限を過ぎていないかの判定
    if deadline < today
      result = false
    end  
    
    return result
    
  end
end