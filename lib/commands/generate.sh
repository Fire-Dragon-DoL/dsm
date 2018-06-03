#!/bin/bash

source "${app_path}/lib/utils/has_migration.sh"
source "${app_path}/lib/utils/template_from.sh"

dsm_cmd_generate() {
  local title="$@"

  if dsm_has_migration "$title"; then
    >&2 echo "Migration with title \"${title}\" already exists"
    return $err_title_exists
  fi

  local target_path="$(date +%s)_${title}"
  local up_path="${project}/${target_path}.up.sql"
  local down_path="${project}/${target_path}.down.sql"

  dsm_template_from "${app_path}/templates/up.sql" "$up_path"
  dsm_template_from "${app_path}/templates/down.sql" "$down_path"

  return 0
}
