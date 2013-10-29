class AddExtraColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :age, :integer
  	add_column :users, :url, :string
  end
end
