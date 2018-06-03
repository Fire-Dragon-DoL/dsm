#!/bin/bash

dsm_get_os_platform() {
  case "$OSTYPE" in
    darwin*) echo "dawin" ;;
    osx*)    echo "dawin" ;;
    linux*)  echo "linux" ;;
    cygwin*) echo "linux" ;;
    msys*)   echo "windows" ;;
    win32*)  echo "windows" ;;
    *)
      echo 'unknown'
      return $err_invalid_os
      ;;
  esac
}
