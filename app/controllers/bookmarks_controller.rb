class BookmarksController < ApplicationController
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def create
    @local = Local.find(params[:local_id])
    bookmark = current_user.bookmark_local(@local)
    bookmark.create_notification_bmk(current_user)
    respond_to do |format|
      format.html {redirect_to @local}
      format.js
    end
  end

  def destroy
    @local = Local.find(params[:local_id])
    current_user.unbookmark_local(@local)
    respond_to do |format|
      format.html {redirect_to @local}
      format.js
    end
  end
end
