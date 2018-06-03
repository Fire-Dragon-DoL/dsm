#!/bin/bash

dsm_cmd_deploy() {
  local deploy_env="$1"
  deploy_env="$(echo "$deploy_env" | awk '{print toupper($0)}')"
  local deploy_target="DSM_DEPLOY_TO_${deploy_env}"
  deploy_target="${!deploy_target}"
  local deploy_dir="DSM_DEPLOY_DIR_${deploy_env}"
  deploy_dir="${!deploy_dir}"

  if [[ -z "${deploy_target}" ]]; then
    >&2 echo '[Error] Missing deploy environment'
    return $err_no_deploy_env
  fi

  if [[ -z "${deploy_dir}" ]]; then
    >&2 echo '[Error] Missing deploy directory'
    return $err_no_deploy_dir
  fi

  echo '--- Configuration ---'
  echo "[Server] ${deploy_target}"
  echo "[Directory] ${deploy_dir}"
  echo ''
  echo '--- Deploy ---'

  set -e
    rsync \
      -az \
      --filter="merge ${app_path}/.rsyncignore" \
      "${app_path}/" \
      "${deploy_target}:dsm"
    rsync -az "${project}/" "${deploy_target}:${deploy_dir}"
    ssh \
      "${deploy_target}" \
      dsm_project_path="$DSM_PROJECT_PATH" \
      dsm_database_url="$DSM_DATABASE_URL" \
      'bash -s' < "${app_path}/lib/remote/run.sh"
  set +e


  return 0
}
