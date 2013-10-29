class AddApprovalKeyToWishes < ActiveRecord::Migration
  def change
  	add_column :wishes, :approval_key, :string
  end
end
