class RecommendsController < ApplicationController
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def index
    @user = current_user

    # @recommends = Local.all.page(params[:page]).per(10)
    # @recommends.to_a.delete_if do |local|
    #   local.difference_rate(@user) < 60
    # end

    @locals = []
    locals = Local.all.includes(%i[score profile tag])

    if current_user.score
      locals.each do |local|
        next unless local.score

        rate = local.difference_rate(@user)
        local.send('match_rate=', rate)

        @locals << local if (local.match_rate >= 60) && (@user.bookmarking?(local) == false)
      end
    end

    @locals.sample(10)
  end
end
