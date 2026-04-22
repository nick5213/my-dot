#!/usr/bin/env bash

GIT_URL="https://github.com/nick5213/my-dot.git"

function help() {
  echo "Usage: ./install.sh <command>"
  echo
  echo "Commands:"
  echo "  init      Init git repository and update remote URL."
  echo "  apps-dev  Install recommended development tools."
  echo
}

function install_check() {
  local sys_type=$(uname)
  if [ "${sys_type}" = "Darwin" ]; then
    return 0
  else
    return 1
  fi
}

function install_app() {
  local cmd=$1
  if install_check; then
    if command -v $cmd >/dev/null 2>&1; then
      echo "> ✅ Already installed: $cmd"
    else
      echo "> 🔧 Installing $cmd"
      brew install $cmd --verbose
    fi
  fi
}

function init_git() {
  local remote_url=$1
  if [ -d ".git" ]; then
    echo "> ✅ Git repository already initialized."
    return 0
  else
    echo "> 🔧 Init Git repository..."
    git init
  fi
  
  # Update the remote URL
  git remote set-url origin $remote_url 2>/dev/null || git remote add origin $remote_url
  echo "> ✅ Remote URL updated to: $remote_url"
}

function git_pull() {
  echo "> 🔄 Pulling remote content..."
  git pull origin main
  git pull origin main || echo "> ⚠️ No changes to pull from remote."
}

function install_dev() {
  echo "> 🔄 Installing recommended development tools..."

  # brew
  #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # cocapods
  # sudo gem install cocoapods

  # openjdk
  # brew install openjdk
  # jenv for java
  # brew install jenv

  # List of recommended dev tools to install
  install_app "git"
  install_app "git-lfs"
  # git lfs install

  install_app "rbenv"
  install_app "tree"
  install_app "wget"
  install_app "scrcpy"
  install_app "maven"
  install_app "node"
  # npm install npm -g

  install_app "pdcopy"
  # prints strings as ASCII art
  install_app "figlet"
}

COMMAND="$1"

case "${COMMAND}" in
  init)
    init_git "${GIT_URL}"
    ;;
  pull)
    git pull origin master
    ;;
  apps-dev)
    install_dev
    ;;
  help)
    help
    ;;
  *)
    help
    ;;
esac