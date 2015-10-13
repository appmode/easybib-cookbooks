include_recipe 'php-fpm::service'

include_recipe 'apt::ppa'
include_recipe 'apt::easybib'

package 'php5-easybib-poppler-pdf' do
  notifies :reload, 'service[php-fpm]', :delayed
end
