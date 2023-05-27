class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy, foreign_key: :follower_id
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy, foreign_key: :sender_id
  has_many :followers, through: :follows, source: :follower
  has_many :followed_users, through: :follows, source: :followed
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
end
