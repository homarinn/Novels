class Novel < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :summary, length: { maximum: 1000 }
  
  has_many :bookmarks
  has_many :users, through: :bookmarks
  has_many :stories, dependent: :destroy
  
  acts_as_taggable
end
