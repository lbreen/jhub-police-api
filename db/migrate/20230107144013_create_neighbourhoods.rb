class CreateNeighbourhoods < ActiveRecord::Migration[7.0]
  def change
    create_table :neighbourhoods do |t|
      t.string :api_id
      t.string :name
      t.string :url, default: ""
      t.float :lat, default: 0
      t.float :long, default: 0
      t.text :description, default: ""
      t.references :force, null: false, foreign_key: true

      t.timestamps
    end
  end
end
