class AddSocialsToForces < ActiveRecord::Migration[7.0]
  def change
    add_column :forces, :twitter_url, :string
    add_column :forces, :facebook_url, :string
    add_column :forces, :youtube_url, :string
  end
end
