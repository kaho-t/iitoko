class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_local!
  def home
    return unless user_signed_in?

    @user = current_user
    redirect_to top_url
  end

  def home_local; end
end
