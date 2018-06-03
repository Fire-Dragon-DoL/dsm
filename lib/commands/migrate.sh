#!/bin/bash

dsm_cmd_migrate() {
  "${app_path}/build/migrate" \
    -source="file://${project}" \
    -database="$database" \
    $@
  return $?
}
