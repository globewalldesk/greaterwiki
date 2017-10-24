class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, index: true
      t.string :author

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
    add_index :messages, [:user_id, :created_at, :author]
  end
end
