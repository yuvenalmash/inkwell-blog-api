class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :likeable, polymorphic: true, null: false, index: true

      t.timestamps
    end
    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true
  end
end
