class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :title, null: false, limit: 100
      t.string :slug, null: false, limit: 100
      t.text :content, null: false
      t.integer :comments_count, null: false, default: 0
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
