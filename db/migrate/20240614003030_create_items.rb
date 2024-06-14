class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.references :wish_list, null: false, foreign_key: true
      t.boolean :single_booking

      t.timestamps
    end
  end
end
