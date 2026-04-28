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
  install_app "lazygit"
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

function install_nvm() {
  if command -v nvm >/dev/null 2>&1; then
    echo "✅ nvm already installed"
    return 0
  fi
  echo "> 🔄 Installing nvm..."

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
  else
    echo "❎ nvm load failed"
    return 1
  fi

  command -v nvm >/dev/null 2>&1 || {
    echo "❎ nvm install failed"
    return 1
  }

  echo "✅ nvm installed"
}

function install_yarn() {
  if command -v yarn >/dev/null 2>&1; then
    echo "✅ Yarn already installed: $(yarn -v)"
    return 0
  fi

  echo "> 🔄 Setting up Yarn via corepack..."

  command -v corepack >/dev/null 2>&1 || {
    echo "❎ corepack not found (Node version too old?)"
    return 1
  }

  corepack enable
  corepack prepare yarn@stable --activate || {
    echo "❎ Yarn setup failed"
    return 1
  }

  # check again
  command -v yarn >/dev/null 2>&1 || {
    echo "❎ Yarn not available after setup"
    return 1
  }

  echo "✅ Yarn: $(yarn -v)"
}

install_bun() {
  if command -v bun >/dev/null 2>&1; then
    echo "✅ Bun already installed: $(bun -v)"
    return 0
  fi

  echo "> 🔄 Installing Bun..."

  curl -fsSL https://bun.sh/install | bash || {
    echo "❎ Bun install failed"
    return 1
  }

  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"

  command -v bun >/dev/null 2>&1 || {
    echo "❎ Bun not available after install"
    return 1
  }

  echo "✅ Bun: $(bun -v)"
}

function install_node() {
  echo "> 🔄 Installing node development tools..."

  # nvm
  install_nvm || return 1

  if command -v node >/dev/null 2>&1; then
    echo "✅ Node already installed: $(node -v)"
  else
    echo "> 🔄 Installing Node (LTS)..."
    nvm install --lts || return 1
    nvm alias default 'lts/*'
    nvm use default
  fi

  echo "✅ Node: $(node -v)"
  echo "✅ npm:  $(npm -v)"

  # yarn
  install_yarn
  # bun
  install_bun
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
