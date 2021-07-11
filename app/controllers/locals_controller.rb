class LocalsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_local!
  def show
    @local = Local.find_by(id: params[:id])
    @articles = @local.articles

    @talkroom = current_user.talkrooms.build if user_signed_in?

    if user_signed_in? && current_user.talking?(@local)
      @room = Talkroom.find_by(user_id: current_user.id,
                               local_id: @local.id)
    end

    @local_headerimage = if @local.image
                           @local.image.url
                         else
                           '/assets/default.png'
                         end

    return unless user_signed_in?

    current_user.visit(@local)
    userfootprints = Footprint.where(['visitoruser_id = ? and visitedlocal_id = ?', current_user.id, @local.id])
    fp = userfootprints.order(created_at: :desc).take
    fp.create_notification_visited(current_user, @local)
  end

  def index
    if user_signed_in?
      @user = current_user
      redirect_to home_url
    end

    @locals = Local.all.includes(%i[profile tag]).sample(10)
  end

  def search
    # @q = Local.search(search_params)
    # @locals = @q.result.includes(:tag).page(params[:page])
    @q = Local.ransack(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    @locals = @q.result(distinct: true).page(params[:page]).includes(%i[profile tag])
  end

  def bookmarks
    @local = Local.find(params[:id])
    @users = @local.users.page(params[:page])
  end

  private

  def search_params
    params.require(:q).permit(:prefecture_code_eq, :tag_sea_true, :tag_mountain_true,
                              :tag_river_true, :tag_field_true, :tag_hotspring_true,
                              :tag_north_true, :tag_south_true, :tag_easy_to_go_true,
                              :tag_small_city_true, :tag_car_true, :tag_train_true,
                              :tag_low_price_true, :tag_moving_support_true,
                              :tag_entrepreneur_support_true, :tag_child_care_support_true,
                              :tag_job_change_support_true, :tag_park_true, :tag_education_true,
                              :tag_food_true, :tag_architecture_true,
                              :tag_history_true, :tag_event_true, :tag_tourism_true)
  end

  def tags
    @tags = { sea: '海', mountain: '山', river: '川', field: '田畑',
              hotspring: '温泉', north: '北国', south: '南国',
              easy_to_go: '都心へ好アクセス', small_city: 'スモールタウン',
              car: '車移動', train: '電車移動', low_price: '物価が安い',
              moving_support: '移住支援', entrepreneur_support: '起業支援',
              child_care_support: '子育て支援', job_change_support: '転職支援',
              park: '公園', education: '教育', food: '食', architecture: '建築・街並み',
              history: '歴史', event: 'イベント・祭', tourism: '観光' }
  end
end
