class BookmarksController < ApplicationController
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def create
    local = Local.find(params[:local_id])
    current_user.bookmark_local(local)
    flash[:success] = "#{local.name}をブックマークしました。"
    redirect_to local
  end

  def destroy
    local = Local.find(params[:local_id])
    current_user.unbookmark_local(local)
    flash[:success] = "#{local.name}をブックマークから削除しました。"
    redirect_to local
  end
end
