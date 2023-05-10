class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :followers, through: :follows, source: :follower
  has_many :followed_users, through: :follows, source: :followed
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password_digest, presence: true

  has_secure_password
end
