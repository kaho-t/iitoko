class LocalsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_local!
  def show
    @local = Local.find_by(id: params[:id])

  end
end
