module BannersHelper

  def show_banner(zone_name)
    return unless bz = BannerZone.find_by_name(zone_name)
    bs = bz.banners.active
    unless bs.empty? 
      banner = bs.sort_by{rand}.first
      image_tag = image_tag(banner.image.url, :width => banner.width, :height => banner.height)
      return link_to image_tag, click_banner_path(banner) 
    end 
  end

end