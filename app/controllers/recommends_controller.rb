class RecommendsController < ApplicationController
  def index
    @user = current_user
  end
end
