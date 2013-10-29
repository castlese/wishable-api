class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.belongs_to :user
      t.boolean :verified, :default => false
      t.string :title
      t.float :cost

      t.timestamps
    end
    add_index :wishes, :user_id
  end
end
