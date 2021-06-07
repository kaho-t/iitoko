class TagsController < ApplicationController
  skip_before_action :authenticate_user!, if: :local_signed_in?
  before_action :correct_local, only: [:edit, :update]
  def new
    @tag = Tag.new
    tags
  end

  def create
    @tag = current_local.build_tag(tag_params)
    if @tag.save
      flash[:success] = "タグが登録されました"
      redirect_to current_local
    else
      render 'tags/new'
    end
  end

  def edit
    tags
  end

  def update
    if @tag.update(tag_params)
      redirect_to current_local
    else
      render 'edit'
    end
  end

  private

  def tags
    @tags = { sea: "海",
              mountain: "山",
              river: "川",
              field: "田畑",
              hotspring: "温泉",
              north: "北国",
              south: "南国",
              easy_to_go: "都心へ好アクセス",
              small_city: "スモールタウン",
              car: "車移動",
              train: "電車移動",
              low_price: "物価が安い",
              moving_support: "移住支援",
              entrepreneur_support: "起業支援",
              child_care_support: "子育て支援",
              job_change_support: "転職支援",
              park: "公園",
              education: "教育",
              food: "食",
              architecture: "建築・街並み",
              history: "歴史",
              event: "イベント・祭",
              tourism: "観光"
            }
  end

  def tag_params
    params.require(:tag).permit(:sea,
                                :mountain,
                                :river,
                                :field,
                                :hotspring,
                                :north,
                                :south,
                                :easy_to_go,
                                :small_city,
                                :car,
                                :train,
                                :low_price,
                                :moving_support,
                                :entrepreneur_support,
                                :child_care_support,
                                :job_change_support,
                                :park,
                                :education,
                                :food,
                                :architecture,
                                :history,
                                :event,
                                :tourism)
  end

  def correct_local
    @tag = Tag.find_by(id: [params[:id]])
    @local = Local.find_by(id: @tag.local_id)
    redirect_to(top_url) unless @local == current_local
  end
end
