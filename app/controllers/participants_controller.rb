class ParticipantsController < ApplicationController
  before_action :require_user_logged_in

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