#!/usr/bin/env sh

fr_backend="${1:-pv}"

#check that what we provide is valid
# shellcheck disable=SC2039
if [[ "$fr_backend" == "fr" ]]; then
    echo "stopping just the base fr service"
    podman-compose  -f docker-compose.frsvc.yml down
    exit 1
elif [[ "$fr_backend" == "pv" ]]; then
  echo "Selected Paravision Engine"
elif [[ "$fr_backend" == "cv" ]]; then
  echo "Selected Clearview Engine"
else
 echo "An invalid FR Engine $fr_backend was requested. cv or pv are the only options"
  exit 1
fi

echo "Shutting down services.."

podman-compose  -f docker-compose.frsvc.yml -f docker-compose.$fr_backend.yml down
