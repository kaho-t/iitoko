class ArticlesController < ApplicationController
  include Rails.application.routes.url_helpers

  skip_before_action :authenticate_user!, if: :local_signed_in?
  skip_before_action :authenticate_local!, if: :user_signed_in?, only: %i[index show]
  before_action :correct_local, only: %i[edit update destroy]
  def index
    @local_title_area = true
    @local = Local.find(params[:local_id])
    @articles = @local.articles.includes([:main_image_attachment, :rich_text_content]).order(created_at: :desc).page(params[:page])
    @talkroom = Talkroom.new
    @local_headerimage = @local.image ? @local.image.url : asset_path('default.png')
    @room = Talkroom.find_by(local: @local, user: current_user)
  end

  def show
    @article = Article.find_by(id: params[:id])
    @local = @article.local
    @articles = Article.where('local_id = ?', @local.id).includes([:main_image_attachment],[:local]).order(created_at: :desc).limit(5)
    @pickups = Article.all.includes([:main_image_attachment],[:local]).sample(3)
  end

  def new
    @article = Article.new
    @article.build_tag
    tags
  end

  def create
    @article = current_local.articles.build(article_params)
    tags
    if @article.save
      @article.create_notification_feed(current_local)
      flash[:success] = '投稿が完了しました'
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    tags
  end

  def update
    tags
    if @article.update(article_params)
      flash[:success] = '記事を更新しました'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = '記事を削除しました'
    redirect_to local_articles_url(current_local)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :main_image,
                                    tag_attributes: %i[sea mountain river field hotspring north south
                                                       easy_to_go small_city car train
                                                       low_price moving_support entrepreneur_support
                                                       child_care_support job_change_support
                                                       park education
                                                       food architecture history event tourism _destroy id])
  end

  def correct_local
    @article = Article.find_by(id: [params[:id]])
    @local = Local.find_by(id: @article.local_id)
    redirect_to local_path(current_local) unless @local == current_local
  end

  def tags
    @tags = { sea: '海', mountain: '山', river: '川', field: '田畑',
              hotspring: '温泉', north: '北国', south: '南国',
              easy_to_go: '都心へ好アクセス', small_city: 'スモールタウン',
              car: '車移動', train: '電車移動',
              low_price: '物価が安い', moving_support: '移住支援',
              entrepreneur_support: '起業支援', child_care_support: '子育て支援',
              job_change_support: '転職支援', park: '公園', education: '教育',
              food: '食', architecture: '建築・街並み', history: '歴史',
              event: 'イベント・祭', tourism: '観光' }
  end
end
