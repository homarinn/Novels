class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  has_many :novels
  has_many :bookmarks
  has_many :likes, through: :bookmarks, source: :novel
  
  def bookmark(bookmark_novel)
    self.bookmarks.find_or_create_by(novel_id: bookmark_novel.id)
  end
  
  def unbookmark(bookmark_novel)
    bookmark = self.bookmarks.find_by(novel_id: bookmark_novel.id)
    bookmark.destroy if bookmark
  end
  
  def bookmarknow?(bookmark_novel)
    self.likes.include?(bookmark_novel)
  end
end
