#!/bin/bash

dsm_download_migrate() {
  which curl
  if [ $? -eq 0 ]; then
    curl -L --fail --output 'migrate.tar.gz' "$1"
    return $?
  fi

  which wget
  if [ $? -eq 0 ]; then
    wget -O 'migrate.tar.gz' "$1"
    return $?
  fi

  >&2 echo "[Error] Can't find wget or curl"
  return $err_missing_downloader
}
