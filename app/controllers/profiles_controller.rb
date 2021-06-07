class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  before_action :correct_local, only: [:edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_local.build_profile(profile_params)
    if @profile.save
      flash[:success] = "プロフィールが登録されました"
      redirect_to new_tag_path
    else
      render 'profiles/new'
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to current_local
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:population,
                                    :temperature,
                                    :moved_in,
                                    :waiting_children,
                                    :land_price,
                                    :income,
                                    :crime_rate,
                                    :introduction)
  end

  def correct_local
    @profile = Profile.find_by(id: [params[:id]])
    @local = Local.find_by(id: @profile.local_id)
    redirect_to(top_url) unless @local == current_local
  end
end
