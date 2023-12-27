class ParticipantsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @user = @curent_user
    @events = @user.participant_events.order(created_at: :desc)
  end

  def create
    @event = Event.find(params[:id])
    current_user.participant(@event)
    flash[:success] = 'イベントに参加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @event = Event.find(params[:id])
    current_user.unparticipant(@event)
    flash[:success] = 'イベントの参加を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end