export PATH="/opt/homebrew/bin:$HOME/.npm-global/bin:/Users/tranlynhathao/Library/pnpm:$PATH"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export BAT_THEME="tokyonight_night"
export NVM_DIR="$HOME/.nvm"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
