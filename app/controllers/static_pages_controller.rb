class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @user = current_user
    render '/recommends/index'
  end

  def home_local; end
end
