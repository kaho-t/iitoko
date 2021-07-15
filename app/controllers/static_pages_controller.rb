class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_local!
  def home
    @title_area = true
    @title_for_local = true
  end
end
