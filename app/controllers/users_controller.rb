class UsersController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def show
    @user = User.find_by(id: params[:id])
    @score = @user.score
    @profile = @user.user_profile
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