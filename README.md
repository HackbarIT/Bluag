## About
Bluag is a lightweight Blog Software. Its written in lua and based on the [luafcgid](https://github.com/HackbarIT/luafcgid)-Server.

## Dependencies
* [luafcgid](https://github.com/HackbarIT/luafcgid)

## Setup

### nginx

This is an sample configuration:

```
server {
  listen                          80;
  listen                          [::]:80;
  server_name                     domain.tld;

  root                            /path/to/bluag;
  index                           index.html index.htm index.lua;

  location ~ \.lua$ {
    fastcgi_pass            unix:/var/tmp/luafcgid.sock;
    fastcgi_param           SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    fastcgi_index           index.lua;
    include                 fastcgi_params;
  }
}
```

Don't forget to restart nginx after the changes!

### luafcgid

* download and compile luafcgid
* run ```./luafcgid scripts/etc/config.debian.lua```


## Maintainer
Georg @georgkrause Krause, Member of [Hackbar.IT](http://hackbar.it/)

## License

[customized ISC-license](https://github.com/HackbarIT/Bluag/blob/master/LICENSE) © Georg Krause
