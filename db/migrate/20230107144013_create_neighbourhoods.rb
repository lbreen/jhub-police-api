class CreateNeighbourhoods < ActiveRecord::Migration[7.0]
  def change
    create_table :neighbourhoods do |t|
      t.string :api_id
      t.string :name
      t.string :url
      t.float :lat
      t.float :long
      t.text :description
      t.references :force, null: false, foreign_key: true

      t.timestamps
    end
  end
end
