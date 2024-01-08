class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :participants]

 
  def show
    @event = Event.find(params[:id])
    # 男性の参加者一覧
    @event_participants_mens = @event.event_participants.where('gender':  'Mens')
    # 女性の参加者一覧
    @event_participants_womens = @event.event_participants.where('gender':  'Womens')
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = 'イベントを投稿しました。'
      redirect_to root_url
    else
      @pagy, @events = pagy(current_user.events.order(id: :desc))
      flash.now[:danger] = 'イベントの投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.participants.destroy_all
    @event.destroy
    flash[:success] = 'イベントを削除しました。'
    redirect_to root_url
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'イベントを更新しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'イベントの更新に失敗しました。'
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:location, :date, :start_time, :end_time, :mensprice, :womansprice, :mensmax_participants, :womansmax_participants, :deadline_time, :memo)
  end

  def admin_user
    redirect_to root_url unless current_user.id == 1
  end
end

