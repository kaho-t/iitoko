class RecommendsController < ApplicationController
  skip_before_action :authenticate_local!, if: :user_signed_in?
  def index
    @user = current_user

    @locals = Local.all.includes(%i[profile tag]).sample(10)

    @recommends = []
    alllocals = Local.all.includes(%i[score profile tag])

    if current_user.score
      alllocals.each do |local|
        next unless local.score

        rate = local.difference_rate(@user)
        local.send('match_rate=', rate)

        @recommends << local if (local.match_rate >= 60) && (@user.bookmarking?(local) == false)
      end
    end

    @recommends = @recommends.sample(10)
  end
end
