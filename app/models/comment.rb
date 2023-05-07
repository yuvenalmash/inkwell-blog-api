class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
