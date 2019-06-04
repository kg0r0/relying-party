# relying-party
## build
```
$ docker build . -t relying-party
$ docker run -p80:80 -it relying-party
```

## usage
* Edit the following directive of httpd.conf
```
OIDCProviderMetadataURL       http://[Issuer URL]/.well-known/openid-configuration 
OIDCClientID                  [Client ID]
OIDCClientSecret [Client Secret]
```

* Access to http://localhost/private