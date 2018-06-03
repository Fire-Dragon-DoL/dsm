#!/bin/bash

dsm_cmd_clean() {
  rm -f "${app_path}/build/migrate"
  return $?
}
