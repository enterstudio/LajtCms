class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :title, :asset_file_file_name, :asset_file_content_type
      t.integer :asset_file_file_size
      t.datetime :asset_file_updated_at
      t.references :page
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
