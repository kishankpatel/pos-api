class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.string :bill_to, null: false
      t.float :total_amount
      t.integer :created_by

      t.timestamps
    end
  end
end
