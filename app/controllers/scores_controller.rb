class ScoresController < ApplicationController
  # before_action :correct_user, only: :update
  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def new
    @score = Score.new
    @user = current_user
    @points = 1..5
  end

  def create
    if current_user
      current_account = current_user
    elsif current_local
      current_account = current_local
    end

    @score = current_account.build_score(score_params)
    if @score.save
      if current_account == current_local
        redirect_to new_profile_url
      else
        redirect_to new_user_profile_url
      end
    else
      render 'score/new'
    end
  end

  def edit
    if current_user
      @current_account = current_user
    elsif current_local
      @current_account = current_local
    end
    @score = @current_account.score
    @points = 1..5
  end

  def update
    if current_user
      @current_account = current_user
    elsif current_local
      @current_account = current_local
    end
    @score = @current_account.score
    if @score.update(score_params)
      redirect_to @current_account
    else
      render 'edit'
    end
  end

  private

  def score_params
    params.require(:score).permit(:nature, :accessibility, :budget, :job_support, :family_support, :culture)
  end

  # def correct_user
  #   @score = current_user.score.find_by(id: params[:id])
  #   redirect_to root_url if @score.nil?
  # end
end
