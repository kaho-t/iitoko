class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  before_action :correct_account, only: [:destroy]
  def index
    @message = Message.new
    @talkroom = Talkroom.find(params[:talkroom_id])
    @messages = Message.where(talkroom_id: params[:talkroom_id]).order(created_at: :asc)
    @user = User.find_by(id: @talkroom.user_id)
    @local = Local.find_by(id: @talkroom.local_id)
  end

  def new
    @talkroom = Talkroom.find(params[:talkroom_id])
    @message = Message.new
  end

  def create
    @talkroom = Talkroom.find(params[:talkroom_id])
    @message = Message.new(message_params)

    if user_signed_in?
      @message.sent_from = current_user.id
      @message.is_user = true
    elsif local_signed_in?
      @message.sent_from = current_local.id
      @message.is_user = false
    else
      redirect_to root_url
    end

    if @message.save
      if user_signed_in?
        @message.create_notification_msg(current_user, @message)
      elsif
        local_signed_in?
        @message.create_notification_msg(current_local, @message)
      end
      flash[:success] = 'メッセージを送信しました'
    else
      flash[:danger] = 'メッセージの送信に失敗しました'
    end
    redirect_to talkroom_messages_path(@talkroom)
  end

  def destroy
    @message.destroy
    flash[:success] = 'メッセージを削除しました'
    redirect_to talkroom_messages_path(@talkroom)
  end


  private
  def message_params
    params.require(:message).permit(:category, :content, :talkroom_id)
  end

  def correct_account
    @message = Message.find(params[:id])
    @talkroom = Talkroom.find_by(id: @message.talkroom_id)

    if user_signed_in? && @message.is_user
      @user = User.find_by(id: @message.sent_from)
      redirect_to(top_url) unless @user == current_user
    elsif local_signed_in? && !@message.is_user
      @local = Local.find_by(id: @message.sent_from)
      redirect_to(root_url) unless @local == current_local
    end
  end
end
