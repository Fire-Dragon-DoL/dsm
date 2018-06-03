#!/bin/bash

if [ -z ${DSM_DATABASE_URL+x} ]; then
  if [ -f "${project}/.dsmrc" ]; then
    source "${project}/.dsmrc"
  fi
fi

if [ -z ${DSM_DATABASE_URL+x} ]; then
  >&2 echo "[Error] No DATABASE_URL supplied"
  exit $err_no_database_url
fi
