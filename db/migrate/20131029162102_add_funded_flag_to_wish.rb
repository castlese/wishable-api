class AddFundedFlagToWish < ActiveRecord::Migration
  def change
  	add_column :wishes, :funded, :boolean, :default => false
  end
end
