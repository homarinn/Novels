class ToppagesController < ApplicationController
  def index
    @novels = Novel.order("updated_at DESC").limit(20)
    @ranking_counts = Bookmark.top_ranking
    @top20_novels = Novel.find(@ranking_counts.keys)
  end
end
