#!/usr/bin/env bash

GIT_URL="https://github.com/nick5213/my-dot.git"

function help() {
  echo "Usage: ./install.sh <command>"
  echo
  echo "Commands:"
  echo "  init      Init git repository and update remote URL."
  echo "  apps-dev  Install recommended development tools."
  echo "  apps-java Install recommended Java development tools."
  echo "  apps-node Install recommended Node development tools."
  echo "  apps-rust Install recommended Rust development tools."
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
  git pull origin main || echo "> ⚠️ No changes to pull from remote."
}

function install_dev() {
  echo "> 🔄 Installing recommended development tools..."

  # brew
  #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # cocapods
  # sudo gem install cocoapods

  # List of recommended dev tools to install
  install_app "git"
  install_app "git-lfs"
  # git lfs install

  install_app "rbenv"
  install_app "pyenv"
  install_app "tree"
  install_app "wget"
  install_app "scrcpy"

  install_app "pdcopy"
  # prints strings as ASCII art
  install_app "figlet"
}

function install_java() {
  echo "> 🔄 Installing java development tools..."
  # openjdk
  # brew install openjdk

  # jenv for java
  install_app "jenv"

  install_app "maven"
}

function install_node() {
  echo "> 🔄 Installing node development tools..."

  # node
  # install_app "node"

  # nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

  # load nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install --lts

  nvm alias default 'lts/*'

  nvm use default

  node -v
  npm -v
}

function install_rust() {
  if command -v rustc &> /dev/null; then
    echo "> ✅ Rust is already installed."
    read -p "Do you want to reinstall Rust? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
      echo "> 🔄 Installing rust development tools..."

      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
      echo "> ✅ Rust reinstallation completed."
    else
      echo "> 🛑 Skipping rust installation."
    fi
  else
    echo "> 🔄 Installing rust development tools..."

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "> ✅ Rust installation completed."
  fi
}

COMMAND="$1"

case "${COMMAND}" in
  init)
    init_git "${GIT_URL}"
    ;;
  pull)
    git_pull
    ;;
  apps-dev)
    install_dev
    ;;
  apps-java)
    install_java
    ;;
 apps-node)
    install_node
    ;;
  apps-rust)
    install_rust
    ;;
  help)
    help
    ;;
  *)
    help
    ;;
esac