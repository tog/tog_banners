click_banner '/banners/:id', :action => 'click', :controller => 'banners'

namespace(:admin) do |admin|
  admin.resources :banners
  admin.resources :banner_zones
end