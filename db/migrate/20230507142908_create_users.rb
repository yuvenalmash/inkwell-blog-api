class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 20
      t.string :avatar, null: false, default: ""
      t.string :bio, null: false, default: ""
      t.integer :posts_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.integer :likes_count, null: false, default: 0
      t.boolean :is_admin, null: false, default: false

      t.timestamps
    end
  end
end
