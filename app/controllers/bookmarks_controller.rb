class BookmarksController < ApplicationController
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def create
    @local = Local.find(params[:local_id])
    bookmark = current_user.bookmark_local(@local)
    bookmark.create_notification_bmk(current_user)
    respond_to do |format|
      format.html { redirect_to @local }
      format.js
    end
  end

  def destroy
    if params[:local_id]
      @local = Local.find(params[:local_id])
      current_user.unbookmark_local(@local)
      respond_to do |format|
        format.html { redirect_to @local }
        format.js
      end
    else
      @bookmark = Bookmark.find_by(id: params[:id])
      @user = User.find_by(id: @bookmark.user_id)
      redirect_to(top_url) unless @user == current_user

      @bookmark.destroy
      redirect_to bookmarks_user_path(@user)
    end
  end

  private

  def correct_account
    @bookmark = Bookmark.find_by(id: params[:id])
    @user = User.find_by(id: @bookmark.user_id)
    redirect_to(top_url) unless @user == current_user
  end
end
