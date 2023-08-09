# script to create fallai with configurations for proxy for angular
# the script allows you to create a file and update it by adding another link for proxying
# Author: kotorkovsciy

# example of working with a script
# create file
# bash ./create-proxy-conf-angular.sh -c -p ./proxy.conf.json -t http://localhost:5000 -ur /api -prO "^/api" -prN ""
# output
# {
#   "/api": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/api": ""
#     }
#   }
# }
# update file
# bash ./create-proxy-conf-angular.sh -u -p ./proxy.conf.json -t http://localhost:5000 -prO "^/static" -prN "" -ur /media
# output
# {
#   "/api": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/api": ""
#     }
#   },
#   "/media": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/static": ""
#     }
#   }
# }
# example of using all parameters
# bash ./create-proxy-conf-angular.sh -c -p ./proxy.conf.json -t http://localhost:5000 -ur /api -prO "^/static" -prN "" -co "true" -ll "debug"
# output
# {
#   "/api": {
#     "target": "http://localhost:5000",
#     "secure": false,
#     "pathRewrite": {
#       "^/static": ""
#     },
#     "changeOrigin": true,
#     "logLevel": "debug"
#   }
# }

# variables
path="$(dirname "$(readlink -f "$0")")/proxy.conf.json"
target="http://localhost:8080"
url="/api"
secure="false"
pathRewriteOld=""
pathRewriteNew=""
changeOrigin=""
logLevel=""
create="false"
update="false"

# read arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo "Usage: bash ./create-proxy-conf-angular.sh [-c|-u] [-p <path>] [-t <target>] [-s <secure>] [-ur <url>] [-prO <pathRewriteOld>] [-prN <pathRewriteNew>] [-co <changeOrigin>] [-ll <logLevel>]"
    echo "Options:"
    echo "  -h, --help            show brief help"
    echo "  -e, --examples        show examples"
    echo "  -c, --create          create file"
    echo "  -u, --update          update file"
    echo "  -p, --path            path to file"
    echo "  -t, --target          target"
    echo "  -s, --secure          secure"
    echo "  -ur, --url            url"
    echo "  -prO, --pathRewriteOld  pathRewriteOld"
    echo "  -prN, --pathRewriteNew  pathRewriteNew"
    echo "  -co, --changeOrigin   changeOrigin"
    echo "  -ll, --logLevel       logLevel"
    exit 0
    ;;
    -e|--examples)
    echo "example of working with a script"
    echo "create file"
    echo "bash ./create-proxy-conf-angular.sh -c -p ./proxy.conf.json -t http://localhost:5000 -ur /api -prO \"^/api\" -prN \"\""
    echo "output"
    echo "{
    \"/api\": {
        \"target\": \"http://localhost:5000\",
        \"secure\": false,
        \"pathRewrite\": {
        \"^/api\": \"\"
        }
    }
}"
    echo "update file"
    echo "bash ./create-proxy-conf-angular.sh -u -p ./proxy.conf.json -t http://localhost:5000 -prO \"^/static\" -prN \"\" -ur /media"
    echo "output"
    echo "{
    \"/api\": {
        \"target\": \"http://localhost:5000\",
        \"secure\": false,
        \"pathRewrite\": {
        \"^/api\": \"\"
        }
},
    \"/media\": {
        \"target\": \"http://localhost:5000\",
        \"secure\": false,
        \"pathRewrite\": {
        \"^/static\": \"\"
        }
    }
}"
    echo "example of using all parameters"
    echo "bash ./create-proxy-conf-angular.sh -c -p ./proxy.conf.json -t http://localhost:5000 -ur /api -prO \"^/static\" -prN \"\" -co \"true\" -ll \"debug\""
    echo "output"
    echo "{
    \"/api\": {
        \"target\": \"http://localhost:5000\",
        \"secure\": false,
        \"pathRewrite\": {
        \"^/static\": \"\"
        },
        \"changeOrigin\": true,
        \"logLevel\": \"debug\"
    }
}"
    exit 0
    ;;
    -p|--path)
    path="$2"
    shift # past argument
    shift # past value
    ;;
    -t|--target)
    target="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--secure)
    secure="$2"
    shift # past argument
    shift # past value
    ;;
    -c|--create)
    create="true"
    shift # past argument
    ;;
    -u|--update)
    update="true"
    shift # past argument
    ;;
    -ur|--url)
    url="$2"
    shift # past argument
    shift # past value
    ;;
    -prO|--pathRewriteOld)
    pathRewriteOld="$2"
    shift # past argument
    shift # past value
    ;;
    -prN|--pathRewriteNew)
    pathRewriteNew="$2"
    shift # past argument
    shift # past value
    ;;
    -co|--changeOrigin)
    changeOrigin="$2"
    shift # past argument
    shift # past value
    ;;
    -ll|--logLevel)
    logLevel="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    echo "unknown option $1"
    exit 1
    ;;
esac
done

# if create and update are not specified, then exit
if [ "$create" = "false" ] && [ "$update" = "false" ]; then
    echo "create or update must be specified"
    exit 1
fi

# if create and update are specified, then exit
if [ "$create" = "true" ] && [ "$update" = "true" ]; then
    echo "create and update can not be specified at the same time"
    exit 1
fi


function write_to_file {
    echo "  \"$url\": {" >> $path
    echo "    \"target\": \"$target\"," >> $path
    echo "    \"secure\": $secure," >> $path
    if [ "$pathRewriteOld" != "" ]; then
        echo "    \"pathRewrite\": {" >> $path
        echo "      \"$pathRewriteOld\": \"$pathRewriteNew\"" >> $path
        echo "    }," >> $path
    fi
    if [ "$changeOrigin" != "" ]; then
        echo "    \"changeOrigin\": $changeOrigin," >> $path
    fi
    if [ "$logLevel" != "" ]; then
        echo "    \"logLevel\": \"$logLevel\"," >> $path
    fi
    # checking if there is an extra comma at the end of the file
    lastChar=$(tail -c 2 $path)
    if [ "$lastChar" = "," ]; then
        echo $(sed '$ s/.$//' $path) > $path
    fi
    echo "  }" >> $path
}

function check_file {
    if [ ! -f "$path" ]; then
        echo "file $path not found"
        exit 1
    fi
}

# create file
if [ "$create" = "true" ]; then
    # create file
    echo "{" > $path

    # write link
    write_to_file

    # write last brackets
    echo "}" >> $path

    # format file
    jq . $path > $path.tmp && mv $path.tmp $path

    echo "file $path created"
fi

# update file
if [ "$update" = "true" ]; then
    # check file
    check_file

    # format file
    jq . $path > $path.tmp && mv $path.tmp $path

    # since the link is already written in the file, you need to remove the last brackets
    sed -i '$ d' $path
    echo "," >> $path

    # write new link
    write_to_file

    # write last brackets
    echo "}" >> $path

    # format file
    jq . $path > $path.tmp && mv $path.tmp $path

    echo "file $path updated"
fi
