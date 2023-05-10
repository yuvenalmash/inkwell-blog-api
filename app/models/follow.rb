class Follow < ApplicationRecord
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :followed_id, presence: true
  validates :follower_id, presence: true

  after_create :increment_follows_count
  after_destroy :decrement_follows_count

  private

  def increment_follows_count
    followed.increment!(:followers_count)
    follower.increment!(:followed_count)
  end

  def decrement_follows_count
    followed.decrement!(:followers_count)
    follower.decrement!(:followed_count)
  end
end
