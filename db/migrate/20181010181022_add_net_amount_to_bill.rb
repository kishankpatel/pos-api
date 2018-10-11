class AddNetAmountToBill < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :net_amount, :float
  end
end
