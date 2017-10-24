class AddTitleAndDescToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :description, :text
  end
end
