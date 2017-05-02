class RemoveItemsFromBuckets < ActiveRecord::Migration[5.0]
  def change
    remove_column :buckets, :items, :string
  end
end
