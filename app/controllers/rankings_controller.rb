class RankingsController < ApplicationController
  def novel
    @ranking_counts = Bookmark.ranking
    @novels = Novel.find(@ranking_counts.keys)
  end
end
