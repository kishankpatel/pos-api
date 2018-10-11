class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.integer :created_by

      t.timestamps
    end
  end
end
