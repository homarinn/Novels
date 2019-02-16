class BookmarksController < ApplicationController
  before_action :require_user_logged_in
  def create
    novel = Novel.find(params[:novel_id])
    current_user.bookmark(novel)
    flash[:success] = "ブックマークしました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    novel = Novel.find(params[:novel_id])
    current_user.unbookmark(novel)
    flash[:success] = "ブックマークを解除しました。"
    redirect_back(fallback_location: root_url)
  end
end
