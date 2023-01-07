class CreateForces < ActiveRecord::Migration[7.0]
  def change
    create_table :forces do |t|
      t.string :api_id
      t.string :name
      t.text :description, default: ""
      t.string :telephone, default: ""
      t.string :url, default: ""
      t.string :twitter_url, default: ""
      t.string :facebook_url, default: ""
      t.string :youtube_url, default: ""

      t.timestamps
    end
  end
end
