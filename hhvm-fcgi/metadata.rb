name              "hhvm-fcgi"
maintainer        "Richard Wossal"
maintainer_email  "richard@lagged.biz"
license           "PHP License"
description       "Installs and configures HHVM FastCGI."
version           "0.1"
recipe            "hhvm-fcgi::default", "Set-up and start the hhvm fcgi server"
supports 'ubuntu'

depends "apt"
depends "aptly"
depends "easybib"
