class CreateBillItems < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_items do |t|
      t.integer :bill_id, null: false
      t.integer :item_id, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
