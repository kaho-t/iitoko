class TalkroomsController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  before_action :correct_account, only: [:destroy]

  def create
    @local = Local.find_by(id: params[:talkroom][:local_id])
    @talkroom = Talkroom.new(talkroom_params)
    if @talkroom.save
      if user_signed_in?
        @talkroom.create_notification_tkrm(current_user, @talkroom)
      elsif local_signed_in?
        @talkroom.create_notification_tkrm(current_local, @talkroom)
      end
      flash[:notice] = 'トークルームが作成されました'
      redirect_to new_talkroom_message_path(@talkroom)
    else
      flash[:danger] = 'トークルームの作成に失敗しました'
      redirect_to local_path(@local)
    end
    # if user_signed_in?
    #   @local = Local.find(params[:local_id])
    #   current_user.start_talking(@local)
    #   flash[:success] = "トークルームが作成されました"
    #   redirect_to new_talkroom_message_path(@talkroom)
    # elsif local_signed_in?
    #   @user = User.find(params[:user_id])
    #   current_local.start_talking(@user)
    #   flash[:success] = "トークルームが作成されました"
    #   redirect_to new_message_path
    # else
    #   redirect_to root_path
    # end
  end

  def index
    if user_signed_in?
      @talkrooms = current_user.talkrooms.includes([:local], [:messages]).page(params[:page]).per(10)
      @talking_withs = current_user.talking_withs
    elsif local_signed_in?
      @talkrooms = current_local.talkrooms.includes([:user], [:messages]).page(params[:page]).per(10)
      @talking_withs = current_local.talking_withs
    else
      redirect_to root_path
    end
  end

  def destroy
    @talkroom.destroy
    flash[:notice] = 'トークルームを削除しました'
    redirect_to talkrooms_url
  end

  private

  def correct_account
    @talkroom = Talkroom.find_by(id: params[:id])

    if user_signed_in?
      @user = User.find_by(id: @talkroom.user_id)
      redirect_to(top_url) unless @user == current_user
    elsif local_signed_in?
      @local = Local.find_by(id: @talkroom.local_id)
      redirect_to(root_url) unless @local == current_local
    end
  end

  def talkroom_params
    params.require(:talkroom).permit(:local_id, :user_id)
  end
end
