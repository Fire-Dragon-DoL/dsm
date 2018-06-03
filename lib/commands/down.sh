#!/bin/bash

source "${app_path}/lib/commands/migrate.sh"

dsm_cmd_down() {
  if [[ -z "${@// }" ]]; then
    dsm_cmd_migrate down 1
  else
    dsm_cmd_migrate down "$@"
  fi
  return $?
}
