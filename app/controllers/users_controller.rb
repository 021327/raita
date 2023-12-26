class UsersController < ApplicationController
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
    
  def participants
    @user = User.find(params[:id])
    @pagy, @events = pagy(@user.participant_events)
    counts(@user)
  end
    
    
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :age, :gender, :password, :password_confirmation)
  end
end