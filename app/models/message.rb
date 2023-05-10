class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :content, presence: true, length: { maximum: 1000 }
  validates :recipient_id, presence: true
end
