# == Schema Information
# Schema version: 20100824053731
#
# Table name: banner_zones
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  width      :integer
#  height     :integer
#  created_at :datetime
#  updated_at :datetime
#

class BannerZone < ActiveRecord::Base
  
  has_many :banners, :dependent => :nullify
  
  def description
    "#{name} (#{width}x#{height})"
  end
  
end
