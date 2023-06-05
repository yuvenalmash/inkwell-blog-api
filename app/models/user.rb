class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
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

  def generate_jwt
    JWT.encode({ id: id,
                 exp: 1.day.from_now.to_i },
               Rails.application.credentials.secret_key_base)
  end
end
