#!/bin/bash

dsm_has_migration() {
  # Checks if migration exists
  # $1 title
  find "${project}" -type f -name "*_${1}.*.sql" | grep -q "."
  return $?
}
