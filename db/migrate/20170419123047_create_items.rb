class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :done
      t.references :bucket, foreign_key: true

      t.timestamps
    end
  end
end
