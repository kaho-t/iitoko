class ScoresController < ApplicationController
  # before_action :correct_user, only: :update
  
  def new
    @score = Score.new
    @user = current_user
    @points = 0..5
  end

  def create
    @score = current_user.build_score(score_params)
    if @score.save
      redirect_to top_url
    else
      render 'score/new'
    end
  end

  def edit
    @user = current_user
    @score = current_user.score
    @points = 0..5
  end

  def update
    @user = current_user
    @score = @user.score
    if @score.update(score_params)
      redirect_to user_url
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
