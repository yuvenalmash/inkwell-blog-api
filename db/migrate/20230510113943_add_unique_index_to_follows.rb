class AddUniqueIndexToFollows < ActiveRecord::Migration[7.0]
  def change
    add_index :follows, [:follower_id, :followed_id], unique: true
  end
end
