# Cookbook for Sinopia-Github

##DESCRIPTION:
This cookbook adds the sinopia github project to a sinopia setup

##USAGE:
web interface is here prolly: http://vagrant:4873/ - use your github credentials to login

##Example deploy.json

```
{
  "sinopia": {
    "user": "root",
    "listen": "0.0.0.0:4873"
  },
  "sinopia-github": {
    "install_path": "/usr/lib/node_modules/sinopia/node_modules/",
    "auth": {
      "type": "github",
      "org": "github_org",
      "client_id": "github_client_id",
      "client_secret": "github_client_secret",
      "ttl": "300"
    }
  }
}
```

