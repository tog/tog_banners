require_plugin 'tog_core'

require "i18n" unless defined?(I18n)
Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

Tog::Plugins.helpers BannersHelper


banners = Tog::Interface.sections(:admin).add "Banners", "/admin/banners"
banners.add_item "Banners", "/admin/banners"
banners.add_item "Zones", "/admin/banner_zones"
