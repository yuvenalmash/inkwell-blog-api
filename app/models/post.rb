class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :slug, presence: true, length: { maximum: 100 }

  after_create :increment_posts_count
  after_destroy :decrement_posts_count

  private

  def increment_posts_count
    user.increment!(:posts_count)
  end

  def decrement_posts_count
    user.decrement!(:posts_count)
  end
end
