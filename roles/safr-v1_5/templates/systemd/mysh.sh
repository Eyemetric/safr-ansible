#!/bin/bash


podman pod create --infra \
--name safr-pod \
--network frnetwork \
-p 5433:5432 \
-p 443:443 \
-p 3031:80 \
-p 3032:443 \
-p 3033:3000


podman container run \
 	--pod=safr-pod \
	-d \
	--replace \
	--name frdb \
	--env POSTGRES_USER=admin \
	--env POSTGRES_PASSWORD=admin \
	--env POSTGRES_DB=safr \
	--volume /opt/eyemetric/fr/data/safr_pgdata/_data:/var/lib/postgresql/data:Z \
	docker.io/postgres:14.1

podman container run \
	--pod=safr-pod \
	-d \
	--replace \
	--name fr-api \
	--env USE_TLS=false \
	--env SAFR_DB_ADDR=10.2.0.4 \
	--env SAFR_DB_PORT=5433 \
	--env FR_BACKEND=pv \
	--env CV_URL=http://onprem-search-engine:7000 \
	--env PV_IDENT_URL=http://10.2.0.4:8080/v4 \
	--env PV_PROC_URL=http://10.2.0.4:8081/v6 \
	--env MIN_MATCH=0 \
	--env MATCH_EXPIRES=10 \
	--env MIN_QUALITY=0.8 \
	--env MIN_DUPE_MATCH=0.98 \
	--env TPASS_USER=admin \
	--env TPASS_PWD=njbs1968 \
	--env TPASS_ADDR=https://devsys01.tpassvms.com/TpassPVService/ \
	--env RUST_LOG=info \
	--env TZ=America/New_York \
	--volume /opt/eyemetric/fr/certs:/cert  docker.io/eyemetricfr/fr-api:1.5.1

