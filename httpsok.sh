#!/usr/bin/env bash

# WIKI: https://httpsok.com/doc/
# This script only supports bash, do not support posix sh.
# If you have the problem like Syntax error: "(" unexpected (expecting "fi"),
# Try to run "bash -version" to check the version.
# Try to visit WIKI to find a solution.

PROJECT_NAME="httpsok"
PROJECT_ENTRY="httpsok"
PROJECT_HOME="$HOME/.httpsok"
PROJECT_ENTRY_BIN="$PROJECT_HOME/$PROJECT_ENTRY"
VERSION="v2"


_mkdirs() {
  _dir="$1"
  if [ ! "$_dir" = "" ]; then
    if [ ! -d "$_dir" ]; then
      mkdir -p "$_dir" && echo "Create directory $_dir success."
    fi
  fi
}

_initpath() {
  _mkdirs "$PROJECT_HOME"
}

_install() {
  _initpath

  ARCH=$(uname -m)
  if [ "$ARCH" == "x86_64" ]; then
    ARCH="x86_64"
  elif [ "$ARCH" == "aarch64" ]; then
    ARCH="aarch64"
  elif [ "$ARCH" == "i686" ]; then
    ARCH="i686"
  elif [ "$ARCH" == "arm64" ]; then
    echo "Architecture arm64 is not supported yet, please use aarch64 or x86_64 architecture"
    exit 1
  else
    echo "Unsupported architecture: $ARCH"
    exit 1
  fi

  SCRIPT_URL="https://cdn.httpsok.com/archive/$VERSION/httpsok-$ARCH-unknown-linux-musl"
  FILE_SIZE=$(curl -sI "$SCRIPT_URL" 2>&1 | grep -i "content-length" | awk '{print $2}' | tr -d '\r')
  FILE_SIZE_BIN=""
  if [ -f "$PROJECT_ENTRY_BIN" ]; then
    FILE_SIZE_BIN=$(stat -c %s "$PROJECT_ENTRY_BIN" 2>/dev/null || true)
  fi
  if [ -n "$FILE_SIZE" ] && [ -n "$FILE_SIZE_BIN" ] && [ "$FILE_SIZE" == "$FILE_SIZE_BIN" ]; then
    echo "File already exists, skip download."
    return
  fi

  echo "Downloading $PROJECT_NAME..."
  curl -s "$SCRIPT_URL" > "$PROJECT_ENTRY_BIN" && chmod +x "$PROJECT_ENTRY_BIN"
  if [ -x "$PROJECT_ENTRY_BIN" ] ; then
    echo "Download $PROJECT_NAME complete."
  else
    echo "Download $PROJECT_NAME failed."
    exit 4
  fi
}

_runing() {
  echo "Running $PROJECT_NAME..."
  $PROJECT_ENTRY_BIN -s $1
}

show_help() {
  echo "Please provide a token to install $PROJECT_NAME."
  echo "Usage: $PROJECT_NAME <token>"
  echo "Example: $PROJECT_NAME 1234567890"
  echo "Please visit https://httpsok.com/ to get a token."
  exit 1
}

main() {
  [ -z "$1" ] && show_help && return
  _install "$@" && _runing "$@"
}

main "$@"