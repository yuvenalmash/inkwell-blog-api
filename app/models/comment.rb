class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 500 }

  after_create :increment_comments_count
  after_destroy :decrement_comments_count

  private

  def increment_comments_count
    user.increment!(:comments_count)
  end

  def decrement_comments_count
    user.decrement!(:comments_count)
  end
end
