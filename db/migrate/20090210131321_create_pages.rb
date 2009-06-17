class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :slug
      AppConfig.languages.values.each do |lang|
        t.text :"title_#{lang}", :"content_#{lang}"
      end
      t.integer :parent_id
      t.integer :position, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
