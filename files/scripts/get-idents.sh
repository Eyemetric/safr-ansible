#!/bin/bash

curl -k -X POST -H "Content-Type: application/json" -d '{ "page_size": 10000 }' https://localhost/fr/idents | jq
