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
Usage: bash ./create-proxy-conf-angular.sh [-c|-u] [-p <path>] [-t <target>] [-s <secure>] [-ur <url>] [-prO <pathRewriteOld>] [-prN <pathRewriteNew>] [-co <changeOrigin>] [-ll <logLevel>]

Options:
  -h, --help            show brief help
  -e, --examples        show examples
  -c, --create          create file
  -u, --update          update file
  -p, --path            path to file
  -t, --target          target
  -s, --secure          secure
  -ur, --url            url
  -prO, --pathRewriteOld  pathRewriteOld
  -prN, --pathRewriteNew  pathRewriteNew
  -co, --changeOrigin   changeOrigin
  -ll, --logLevel       logLevel
```

## License
[MIT](https://choosealicense.com/licenses/mit/)

## TODO
- [ ] Create method for multiple proxy
