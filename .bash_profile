# Add `~/bin` to the `$PATH`
export PATH="/usr/bin:$PATH";
export PATH="$PATH:/usr/local/bin"
# support M1
export PATH="$PATH:/opt/homebrew/bin"

# xcode path
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export PATH="$PATH:$SDKROOT"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,bash_local}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/build-tools"
export PATH="$PATH:$ANDROID_HOME/build-tools/34.0.0" 
export PATH="$PATH:$ANDROID_HOME/emulator" 
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME"
# Android NDK
export NDK_HOME="$ANDROID_HOME/ndk/21.1.6352462"
export NDK_ROOT="$NDK_HOME"
export PATH=$PATH:$NDK_HOME
export PATH="$PATH:$NDK_HOME/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin"
export PATH="$PATH:$NDK_HOME/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin"
export PATH="$PATH:$NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin"

# ohos
export OHOS_HOME="$HOME/Library/OpenHarmony/Sdk"
export PATH="$PATH:$OHOS_HOME/13/toolchains"

#export OHOS_HOME="$HOME/develop/ohos"
#export PATH="$PATH:$OHOS_HOME/command-line-tools/bin"

# cmake
export PATH="$PATH:$CMAKE_HOME/bin"

# python
export PATH="$PATH:$PYTHON3_HOME/bin"

## hack ##
# jadx
export PATH="$PATH:$JADX_HOME/bin"

# class-dump
export PATH="$PATH:$CLASS_DUMP_HOME"

# dextra
DEXTRA_HOME="$HOME/develop/decompile/tools/dextra/"
export PATH="$PATH:$DEXTRA_HOME"

# add rvm path
export PATH="$PATH:$HOME/.rvm/bin"
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
