# == Schema Information
# Schema version: 20100824053731
#
# Table name: banner_clicks
#
#  id         :integer         not null, primary key
#  banner_id  :integer
#  user_agent :string(255)
#  ip         :string(255)
#  referer    :string(255)
#  user_id    :integer
#  session_id :string(255)
#  click_hash :string(255)
#  created_at :datetime
#

class BannerClick < ActiveRecord::Base
  
  belongs_to :banner
  belongs_to :user
  
  def click_date(format=:short)
    I18n.l(self.created_at, :format => format)
  end
  
end
