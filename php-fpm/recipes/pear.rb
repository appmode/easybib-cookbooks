#
# Cookbook Name:: php-fpm
# Recipe:: pear
#
# Copyright 2010-2011, Till Klampaeckel
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this list
#   of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or other
#   materials provided with the distribution.
# * The names of its contributors may not be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

execute "PEAR: enable auto discover for channels" do
  command "pear config-set auto_discover 1"
end

is_installed = lambda do |package|
  cmd = "pear list -c pear.php.net|grep #{package}|wc -l"
  val = `#{cmd}`
  if val == 1
    return true
  end
  return false
end

packages = {
  "pear.php.net"           => "Crypt_HMAC2-beta",
  "pear.php.net"           => "Net_Gearman-alpha",
  "pear.php.net"           => "Services_Amazon_S3-alpha",
  "pear.php.net"           => "Net_CheckIP2-1.0.0RC3",
  "htmlpurifier.org"       => "HTMLPurifier",
  "pear.geometria-lab.net" => "Rediska-beta"
}

execute "PEAR: update channel" do
  command "pear channel-update pear.php.net"
end

execute "PEAR: upgrade all packages" do
  command "pear upgrade-all"
end

packages.each do |channel,package|
  execute "PEAR: install #{package} from #{channel}" do
    command "pear install -f #{channel}/#{package}"
    not_if  do is_installed.call(package) end
  end
end
