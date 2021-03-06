action :create do
  app = new_resource.app

  if new_resource.path.nil?
    path = ::EasyBib::Config.get_appdata(node, app, 'app_dir')
  else
    path = new_resource.path
  end

  path << '/' unless path.end_with?('/')

  if new_resource.stackname.nil?
    stackname = ::EasyBib.get_normalized_cluster_name(node).split('_').first
  else
    stackname = new_resource.stackname
  end

  Chef::Log.info("writing envconfig for #{app} to #{path}, stackname #{stackname}")

  %w(ini php sh).each do |format|
    template "#{path}.deploy_configuration.#{format}" do
      mode   '0644'
      cookbook 'easybib'
      source 'empty.erb'
      variables(
        :content => ::EasyBib::Config.get_configcontent(format, app, node, stackname)
      )
    end
  end

  new_resource.updated_by_last_action(true)

end
