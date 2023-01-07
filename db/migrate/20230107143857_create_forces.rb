class CreateForces < ActiveRecord::Migration[7.0]
  def change
    create_table :forces do |t|
      t.string :api_id
      t.string :name
      t.text :description
      t.string :telephone
      t.string :url

      t.timestamps
    end
  end
end
