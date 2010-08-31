class CreateBannersTables < ActiveRecord::Migration
  def self.up
    
    create_table :banners do |t|
      t.string :name
      t.references :banner_zone
      t.string :url
      
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      t.integer :frequency
      t.date    :start_date
      t.date    :end_date
      t.boolean :active

      t.timestamps
    end
    
    create_table :banner_zones do |t|
      t.string :name
      t.integer :width
      t.integer :height
      t.timestamps
    end    
    
    create_table :banner_clicks do |t|
      t.references :banner
      t.string :user_agent
      t.string :ip
      t.string :referer
      t.integer :user_id
      t.string :session_id
      t.string :click_hash
      t.timestamp :created_at
    end
    
  end

  def self.down
    drop_table :banners
    drop_table :banner_zones
    drop_table :banner_clicks
  end
end