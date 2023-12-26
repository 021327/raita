class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  end
  
  def show
    @event = Event.find(params[:id])
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
    @event.destroy
    flash[:success] = 'イベントを削除しました。'
    redirect_to root_url
  end
  
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    # イベントの編集内容を更新するアクション
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
  
  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    unless @event
      redirect_to root_url
    end
  end

  def admin_user
    if current_user.id != 1
      redirect_to root_url
    end  
  end  
end