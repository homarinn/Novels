class Story < ApplicationRecord
  belongs_to :novel
  
  validates :subtitle, presence: true, length: { maximum: 100 }
  validates :content, length: { maximum: 50000 }
end
