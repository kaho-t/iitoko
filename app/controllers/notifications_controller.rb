class NotificationsController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?

  def index
    if user_signed_in?
      @notifications = current_user.passive_notifications.where('is_for_user = ? and is_from_user = ?', true,
                                                                false).page(params[:page]).per(10)
      @current_account = current_user
      @notifications.where(is_checked: false).each do |notice|
        notice.update(is_checked: true)
      end
    elsif local_signed_in?
      @notifications = current_local.passive_notifications.where('is_for_user = ? and is_from_user = ?', false,
                                                                 true).page(params[:page]).per(10)
      @current_account = current_local
      @notifications.where(is_checked: false).each do |notice|
        notice.update(is_checked: true)
      end
    end
  end
end
