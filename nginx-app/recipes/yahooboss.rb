if !node[:deploy]
  node[:deploy]             = {}
  node[:deploy][:deploy_to] = '/var/www/yahooboss'
end

node[:docroot] = 'public'

include_recipe "nginx-app::vagrant"
