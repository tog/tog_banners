plugin 'tog_banners', :git => "git://github.com/tog/tog_banners.git"

route "map.routes_from_plugin 'tog_banners'"

generate "update_tog_migration"

rake "db:migrate"