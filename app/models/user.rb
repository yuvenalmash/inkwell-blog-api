class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,,:recoverable, :rememberable, :validatable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy, foreign_key: :follower_id
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy, foreign_key: :sender_id
  has_many :followers, through: :follows, source: :follower
  has_many :followed_users, through: :follows, source: :followed
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
end
