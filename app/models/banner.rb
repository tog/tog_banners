# == Schema Information
# Schema version: 20100824053731
#
# Table name: banners
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  banner_zone_id     :integer
#  url                :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  frequency          :integer
#  start_date         :date
#  end_date           :date
#  active             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#

class Banner < ActiveRecord::Base
  
  has_many :banner_clicks, :dependent => :destroy
  belongs_to :banner_zone
  
  delegate :width, :height, :to => :banner_zone   
  
  named_scope :active, :conditions => {:active => true}
  
  seo_urls

  has_attached_file :image, {
      :url => "/system/:class/:attachment/:id/:style_:basename.:extension"
    }.merge(Tog::Plugins.storage_options)
    
    
  def click!(user, request)
    
    user_id = user ? user.id : nil
    click_hash = Digest::MD5.hexdigest([request.user_agent, request.remote_ip, user_id].compact.join("\n"))
    
    self.banner_clicks.create!(
      :user_id => user_id, 
      :session_id => request.session_options[:id], 
      :referer => request.referer, 
      :user_agent => request.user_agent, 
      :ip => request.remote_ip, 
      :click_hash => click_hash
    ) unless self.banner_clicks.find_by_click_hash(click_hash)
  end
   
end
