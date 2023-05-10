class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  private

  def increment_likes_count
    likeable.increment!(:likes_count)
  end

  def decrement_likes_count
    likeable.decrement!(:likes_count)
  end
end
