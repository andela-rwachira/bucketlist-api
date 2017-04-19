class CreateBuckets < ActiveRecord::Migration[5.0]
  def change
    create_table :buckets do |t|
      t.string :name
      t.string :items
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
