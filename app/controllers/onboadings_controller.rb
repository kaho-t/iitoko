class OnboadingsController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def welcome
    @user = current_user
  end

end
