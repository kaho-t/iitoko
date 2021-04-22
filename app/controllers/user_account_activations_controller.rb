class UserAccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.active
      log_in @user
      flash[:success] = 'ようこそ！'
      redirect_to edit_user_url @user
    else
      flash[:danger] = 'このURLは無効です'
      redirect_to root_url
    end
  end
end
