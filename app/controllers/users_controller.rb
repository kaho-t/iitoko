class UsersController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def show
    @user = User.find_by(id: params[:id])
    @score = @user.score
    @profile = @user.user_profile

    return unless local_signed_in?

    current_local.visit(@user)
    localfootprints = Footprint.where(['visitorlocal_id = ? and visiteduser_id = ?', current_local.id, @user.id])
    fp = localfootprints.order(created_at: :desc).take
    fp.create_notification_visited(current_local, @user)
  end

  def bookmarks
    @user = User.find_by(id: params[:id])
    @bookmarked_locals = @user.locals.page(params[:page])
  end

  # def timeline
  #   local_ids = "SELECT local_id FROM bookmarks WHERE user_id = :user_id"
  #   Article.where("local_id IN (#{local_ids}) self.local_ids)
  # end

  def timeline
    @articles = current_user.feed.page(params[:page])
  end
end
