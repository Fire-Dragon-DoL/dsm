#!/bin/bash

source "${app_path}/lib/utils/has_migration.sh"

dsm_cmd_destroy() {
  local title="$@"

  if ! dsm_has_migration "$title"; then
    >&2 echo "Migration with title \"${title}\" is missing"
    return $err_title_missing
  fi

  find "${project}" -type f -name "*_${title}.*.sql" -exec rm {} +

  return 0
}
