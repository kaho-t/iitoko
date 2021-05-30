class UsersController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def show
    @user = current_user
  end
end