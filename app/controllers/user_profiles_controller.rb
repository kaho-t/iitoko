class UserProfilesController < ApplicationController
  skip_before_action :authenticate_local!, if: :user_signed_in?
  before_action :correct_user, only: [:edit, :update]
  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = UserProfile.new(user_profile_params)

    if @user_profile.save
      flash[:success] = 'プロフィールの登録が完了しました。マイページからいつでも編集できます'
      redirect_to home_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @user_profile.update(user_profile_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

private

  def user_profile_params
    params.require(:user_profile).permit(:prefecture_code, :age, :proposed_site, :job, :family_structure, :timing, :content, :user_id)
  end

  def correct_user
    @user_profile = UserProfile.find_by(id: params[:id])
    redirect_to(home_url) unless @user_profile.user == current_user
  end

end
