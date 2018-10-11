class AddTagsToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :tags, :text
  end
end
