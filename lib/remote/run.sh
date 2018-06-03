#!/bin/bash

dsm_exe="$HOME/dsm/bin/dsm"
export DSM_PROJECT_PATH="$dsm_project_path"
export DSM_DATABASE_URL="$dsm_database_url"

set -e
  echo 'Installing migrate ...'
  if [ ! -f "$HOME/dsm/build/migrate" ]; then
    "$dsm_exe" setup
  else
    echo 'Setup already performed'
  fi
  echo 'Migrating ...'
  "$dsm_exe" up
set +e
