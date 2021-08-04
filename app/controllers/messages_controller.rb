class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  before_action :correct_account, only: [:destroy]
  def index
    @message = Message.new
    @talkroom = Talkroom.find(params[:talkroom_id])
    @messages = Message.where(talkroom_id: params[:talkroom_id]).includes([:pdf_attachment],[:photo_attachment]).order(created_at: :asc)
    @user = User.find_by(id: @talkroom.user_id)
    @local = Local.find_by(id: @talkroom.local_id)
  end

  def new
    @talkroom = Talkroom.find(params[:talkroom_id])
    @message = Message.new
  end

  def create
    @talkroom = Talkroom.find(params[:talkroom_id])
    # @message = Message.new(message_params)

    if user_signed_in?
      saving_message(current_user)
    elsif local_signed_in?
      saving_message(current_local)
    else
      redirect_to root_url
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = 'メッセージを削除しました'
    redirect_to talkroom_messages_path(@talkroom)
  end

  private

  def saving_message(current_account)
    # @message.sender_id = current_account.id
    # @message.sender_type = boolean
    @message = current_account.messages.build(message_params)
    @message.photo.attach(params[:message][:photo])
    @message.pdf.attach(params[:message][:pdf])
    if @message.save
      @message.create_notification_msg(current_account, @message)
      flash[:notice] = 'メッセージを送信しました'
      redirect_to talkroom_messages_path(@talkroom)
    else
      flash[:notice] = 'メッセージの送信に失敗しました'
      @user = User.find_by(id: @talkroom.user_id)
      @local = Local.find_by(id: @talkroom.local_id)
      @messages = Message.where(talkroom_id: params[:talkroom_id]).order(created_at: :asc)
      render 'index'
    end
  end

  def message_params
    params.require(:message).permit(:category, :content, :talkroom_id, :photo, :pdf)
  end

  def correct_account
    @message = Message.find(params[:id])
    @talkroom = Talkroom.find_by(id: @message.talkroom_id)

    if user_signed_in? && (@message.sender_type == 'User')
      @user = User.find_by(id: @message.sender_id)
      redirect_to(top_url) unless @user == current_user
    elsif local_signed_in? && (@message.sender_type == 'Local')
      @local = Local.find_by(id: @message.sender_id)
      redirect_to(root_url) unless @local == current_local
    end
  end
end
