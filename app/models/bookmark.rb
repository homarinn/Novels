class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  
  def self.ranking
    self.group(:novel_id).order("count_novel_id DESC").limit(500).count(:novel_id)
  end
  
  def self.top_ranking
    self.group(:novel_id).order("count_novel_id DESC").limit(20).count(:novel_id)
  end
  
end
