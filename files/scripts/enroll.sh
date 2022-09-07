#!/bin/bash

curl -k -X POST -H "Content-Type: application/json" -d @$1 https://localhost/fr/v2/enrollment/create
