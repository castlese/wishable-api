class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.belongs_to :wish
      t.float :amount

      t.timestamps
    end
    add_index :donations, :wish_id
  end
end
