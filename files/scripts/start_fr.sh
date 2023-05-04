#!/usr/bin/env sh

fr_backend="${1:-pv}"

docker_compose_file="docker-compose.frsvc.yml"

#check that what we provide is valid
# shellcheck disable=SC2039
if [[ "$fr_backend" == "fr" ]]; then
    echo "starting just the base fr service"
    podman-compose  -f docker-compose.frsvc.yml up -d
    exit 1
elif [[ "$fr_backend" == "pv" ]]; then
  echo "Using the Paravision Engine"
elif [[ "$fr_backend" == "cv" ]]; then
  echo "Using the Clearview Engine"
else
 echo "An invalid FR Engine $fr_backend was requested. cv or pv are the only options"
  exit 1
fi
# Use sed to update the environment variable value in the docker-compose file
#That's what she sed. badoom boom.
sed -i "s/\(FR_BACKEND=\)[^[:space:]]*/\1${fr_backend}/" "${docker_compose_file}"
#sed "s/\(FR_BACKEND=\)[^[:space:]]*/\1${fr_backend}/" "${docker_compose_file}"


echo "We run the podman-compose file now and start the $fr_backend backend"
podman-compose  -f docker-compose.frsvc.yml -f docker-compose.$fr_backend.yml up -d
