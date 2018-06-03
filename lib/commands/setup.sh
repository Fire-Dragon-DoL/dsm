#!/bin/bash

source "${app_path}/lib/utils/download_migrate.sh"
source "${app_path}/lib/utils/get_os_platform.sh"

dsm_cmd_setup() {
  local exe_os="$(dsm_get_os_platform)"
  if [ ! $? -eq 0 ]; then
    >&2 echo "[Error] Could not detect OS. You have ${OSTYPE}, detected: ${exe_os}"
    return $err_invalid_os
  fi
  local exe_url="https://github.com/golang-migrate/migrate/releases/download/${migrate_version}/migrate.${exe_os}-amd64.tar.gz"

  set -e
    mkdir -p "${app_path}/build"
    pushd "${app_path}/build" > /dev/null
    echo "Downloading from: $exe_url"
    dsm_download_migrate "$exe_url"
    echo "Unzipping ..."
    tar xzf 'migrate.tar.gz'
    rm -f './migrate.tar.gz'
    mv ./migrate.* './migrate'
    chmod a+x './migrate'
    popd > /dev/null
    echo 'Ready!'
  set +e
  return 0
}
