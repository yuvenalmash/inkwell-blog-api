class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :post, null: false, foreign_key: true, index: true
      t.text :content, null: false
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
