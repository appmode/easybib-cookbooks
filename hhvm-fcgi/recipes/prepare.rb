directory node["php-fpm"]["tmpdir"] do
  mode "0755"
  owner node["hhvm-fcgi"]["user"]
  group node["hhvm-fcgi"]["group"]
end

directory File.dirname(node["php-fpm"]["logfile"]) do
  mode "0755"
  owner node["hhvm-fcgi"]["user"]
  group node["hhvm-fcgi"]["group"]
end

file node["php-fpm"]["logfile"] do
  mode "0755"
  owner node["hhvm-fcgi"]["user"]
  group node["hhvm-fcgi"]["group"]
end

template "/etc/init.d/hhvm" do
  mode   "0755"
  source "init.d.hhvm.erb"
  owner  node["hhvm-fcgi"]["user"]
  group  node["hhvm-fcgi"]["group"]
end
