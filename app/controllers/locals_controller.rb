class LocalsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_local!
  def show
    @local = Local.find_by(id: params[:id])
    @articles = @local.articles

    if @local.image
      @local_headerimage = @local.image.url
    else
      @local_headerimage = "/assets/default.png"
    end

  end
end
