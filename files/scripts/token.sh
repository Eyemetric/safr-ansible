#/bin/bash

curl -k -X POST -H "Content-Type: application/json" -d '{ "username": "admin", "password": "njbs1968" }' https://devsys01.tpassvms.com/tpasspvservice/api/token | jq
