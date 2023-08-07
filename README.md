# create-proxy-conf-angular
script to create file with configurations for proxy for angular

## Example of use
### Create file
```bash
$ bash ./create-proxy-conf-angular.sh -c -p ./proxy.conf.json -t http://localhost:5000 -ur /api
```
#### Output
```json
{
    "/api": {
        "target": "http://localhost:5000",
        "secure": false
    }
}
```
### Update file
```bash
$ bash ./create-proxy-conf-angular.sh -u -p ./proxy.conf.json -t http://localhost:5000 -prO "^/static" -prN "" -ur /media
```
#### Output
```json
{
    "/api": {
        "target": "http://localhost:5000",
        "secure": false
    },
    "/media": {
        "target": "http://localhost:5000",
        "secure": false,
        "pathRewrite": {
            "^/static": ""
        }
    }
}
```
### Example of using all parameters
```bash
$ bash ./create-proxy-conf-angular.sh -c -p ./proxy.conf.json -t http://localhost:5000 -ur /api -prO "^/static" -prN "" -co "true" -ll "debug"
```
#### Output
```json
{
    "/api": {
        "target": "http://localhost:5000",
        "secure": false,
        "pathRewrite": {
            "^/static": ""
        },
        "changeOrigin": true,
        "logLevel": "debug"
    }
}
```
### Help
```bash
$ bash ./create-proxy-conf-angular.sh -h
```
#### Output
```bash
Usage: create-proxy-conf-angular.sh [-c|-u] [-p <path>] [-t <target>] [-ur <url>] [-prO <pathRegexOld>] [-prN <pathRegexNew>] [-co <changeOrigin>] [-ll <logLevel>]

Options:
    -c, --create            Create file
    -u, --update            Update file
    -p, --path              Path of file
    -t, --target            Target of proxy
    -ur, --url              Url of proxy
    -prO, --pathRegexOld    Path regex old of proxy
    -prN, --pathRegexNew    Path regex new of proxy
    -co, --changeOrigin     Change origin of proxy
    -ll, --logLevel         Log level of proxy
    -h, --help              Show this help
```

## License
[MIT](https://choosealicense.com/licenses/mit/)

## TODO
- [ ] Create method for multiple proxy
