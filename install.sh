#!/usr/bin/env bash

# brew
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# cocapods
# sudo gem install cocoapods

# openjdk
# brew install openjdk
# jenv for java
#brew install jenv

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
      echo "> [INFO] Alredy installed: $cmd"
    else
      echo "> [INFO] Installing $cmd"
      brew install $cmd --verbose
    fi
  fi
}

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