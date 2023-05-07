class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }, index: true
      t.references :recipient, null: false, foreign_key: { to_table: :users }, index: true
      t.string :subject, null: false, default: "", limit: 100
      t.text :content, null: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
