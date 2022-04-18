#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

WORKDIR=$(mktemp -d)
LOG_FILE="${WORKDIR}/init.log.$(date +%F%T%Z)"
ECHO_PATH=$(which echo)

function echo() {
    $ECHO_PATH "$@"
    $ECHO_PATH "$@" > "$LOG_FILE"
}

install_homebrew() {
    if ! which brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" > "${LOG_FILE}"
    fi
}

install_homebrew_formulas() {
    echo "Installing Homebrew formulas..."
    brew install 'ack' \
'adns' \
'aom' \
'apr' \
'apr-util' \
'atlas-cli' \
'autoconf' \
'awscli' \
'bash' \
'bash-completion' \
'bdw-gc' \
'berkeley-db' \
'binutils' \
'blackbox' \
'brotli' \
'bzip2' \
'c-ares' \
'ca-certificates' \
'cairo' \
'cassandra' \
'coreutils' \
'curl' \
'cython' \
'diffutils' \
'docker-completion' \
'docker-compose' \
'docker-compose-completion' \
'docker-machine-completion' \
'emacs' \
'expect' \
'fasd' \
'file-formula' \
'findutils' \
'fontconfig' \
'freetype' \
'fribidi' \
'fzf' \
'gawk' \
'gd' \
'gdbm' \
'gettext' \
'giflib' \
'git' \
'git-lfs' \
'git-quick-stats' \
'glib' \
'glide' \
'gmp' \
'gnu-getopt' \
'gnu-indent' \
'gnu-sed' \
'gnu-tar' \
'gnu-time' \
'gnu-which' \
'gnupg' \
'gnuplot' \
'gnutls' \
'go' \
'gobject-introspection' \
'governator-cli' \
'gpatch' \
'gradle' \
'gradle-completion' \
'graphite2' \
'grep' \
'guile' \
'gzip' \
'harfbuzz' \
'helm' \
'htop' \
'httpie' \
'hub' \
'icu4c' \
'imath' \
'jansson' \
'jemalloc' \
'jenv' \
'jpeg' \
'jpeg-xl' \
'jq' \
'kubernetes-cli' \
'lastpass-cli' \
'ldns' \
'less' \
'libassuan' \
'libavif' \
'libcbor' \
'libcerf' \
'libev' \
'libevent' \
'libffi' \
'libfido2' \
'libgcrypt' \
'libgpg-error' \
'libidn2' \
'libksba' \
'libmagic' \
'libnghttp2' \
'libpng' \
'libpthread-stubs' \
'libssh2' \
'libtasn1' \
'libtiff' \
'libtool' \
'libunistring' \
'libusb' \
'libuv' \
'libvmaf' \
'libx11' \
'libxau' \
'libxcb' \
'libxdmcp' \
'libxext' \
'libxml2' \
'libxmlsec1' \
'libxrender' \
'libyaml' \
'libzip' \
'lua' \
'lua@5.1' \
'luarocks' \
'lynx' \
'lz4' \
'lzip' \
'lzo' \
'm4' \
'make' \
'midnight-commander' \
'mpdecimal' \
'mpfr' \
'mvnvm' \
'mysql@5.6' \
'nano' \
'ncurses' \
'netcat' \
'nettle' \
'nghttp2' \
'nmap' \
'node' \
'npth' \
'nvm' \
'oniguruma' \
'opa' \
'openexr' \
'openjdk' \
'openjdk@11' \
'openjdk@8' \
'openldap' \
'openssh' \
'openssl@1.1' \
'p11-kit' \
'pandoc' \
'pango' \
'parallel' \
'pass' \
'pcre' \
'pcre2' \
'perl' \
'pinentry' \
'pinentry-mac' \
'pipx' \
'pixman' \
'pkg-config' \
'popt' \
'postgresql@9.5' \
'protobuf' \
'pv' \
'pwgen' \
'pyenv' \
'pyenv-virtualenv' \
'python@3.10' \
'python@3.8' \
'python@3.9' \
'qrencode' \
'qt@5' \
'rbenv' \
'readline' \
'redir' \
'redis' \
'rename' \
'rsync' \
'rtmpdump' \
'ruby' \
'ruby-build' \
's-lang' \
'screen' \
'shellcheck' \
'six' \
'sl' \
'sqlite' \
'subversion' \
'tcl-tk' \
'telnet' \
'terraform' \
'thefuck' \
'tldr' \
'tmux' \
'tree' \
'unbound' \
'unzip' \
'utf8proc' \
'vim' \
'watch' \
'wdiff' \
'webp' \
'wget' \
'xmlstarlet' \
'xorgproto' \
'xxhash' \
'xz' \
'yarn' \
'zlib' \
'zsh-autosuggestions' \
'zsh-completions' \
'zstd' > "${LOG_FILE}"
}

install_homebrew_cask() {
    local installed=$(brew cask ls -1)

    echo "Installing Homebrew casks..."
    ! echo "${installed}" | grep -w 'google-chrome' &> /dev/null && brew cask install 'google-chrome'
    ! echo "${installed}" | grep -w 'android-file-transfer' &> /dev/null && brew cask install 'android-file-transfer'
    ! echo "${installed}" | grep -w 'appcleaner' &> /dev/null && brew cask install 'appcleaner'
    ! echo "${installed}" | grep -w 'authy' &> /dev/null && brew cask install 'authy'
    ! echo "${installed}" | grep -w 'docker' &> /dev/null && brew cask install 'docker'
    ! echo "${installed}" | grep -w 'dropbox' &> /dev/null && brew cask install 'dropbox'
    ! echo "${installed}" | grep -w 'fluor' &> /dev/null && brew cask install 'fluor'
    ! echo "${installed}" | grep -w 'iina' &> /dev/null && brew cask install 'iina'
    ! echo "${installed}" | grep -w 'iterm2' &> /dev/null && brew cask install 'iterm2'
    ! echo "${installed}" | grep -w 'lastpass' &> /dev/null && brew cask install 'lastpass'
    ! echo "${installed}" | grep -w 'spotify' &> /dev/null && brew cask install 'spotify'
    ! echo "${installed}" | grep -w 'sublime-text' &> /dev/null && brew cask install 'sublime-text'
    ! echo "${installed}" | grep -w 'visual-studio-code' &> /dev/null && brew cask install 'visual-studio-code'
    ! echo "${installed}" | grep -w 'intellij-idea' &> /dev/null && brew cask install 'intellij-idea'
    ! echo "${installed}" | grep -w 'whatsapp' &> /dev/null && brew cask install 'whatsapp'
}

init_macos() {
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
    defaults delete com.apple.HIToolbox AppleEnabledInputSources
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>InputSourceKind</key> <string>Keyboard Layout</string> <key>KeyboardLayout ID</key> <integer>15</integer> <key>KeyboardLayout Name</key> <string>Australian</string> </dict>'
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.TCIM</string> <key>Input Mode</key> <string>com.apple.inputmethod.TCIM.Pinyin</string> <key>InputSourceKind</key> <string>Input Mode</string> </dict>'
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.TCIM</string> <key>InputSourceKind</key> <string>Keyboard Input Method</string> </dict>'
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.ChineseHandwriting</string> <key>InputSourceKind</key> <string>Non Keyboard Input Method</string> </dict>'    
    defaults delete com.apple.HIToolbox AppleInputSourceHistory
    defaults write com.apple.HIToolbox AppleInputSourceHistory -array-add '<dict> <key>InputSourceKind</key> <string>Keyboard Layout</string> <key>KeyboardLayout ID</key> <integer>15</integer> <key>KeyboardLayout Name</key> <string>Australian</string> </dict>'
    defaults write com.apple.HIToolbox AppleInputSourceHistory -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.TCIM</string> <key>Input Mode</key> <string>com.apple.inputmethod.TCIM.Pinyin</string> <key>InputSourceKind</key> <string>Input Mode</string> </dict>'
    defaults delete com.apple.HIToolbox AppleSelectedInputSources
    defaults write com.apple.HIToolbox AppleSelectedInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.PressAndHold</string> <key>InputSourceKind</key> <string>Non Keyboard Input Method</string> </dict>'
    defaults write com.apple.HIToolbox AppleSelectedInputSources -array-add '<dict> <key>InputSourceKind</key> <string>Keyboard Layout</string> <key>KeyboardLayout ID</key> <integer>15</integer> <key>KeyboardLayout Name</key> <string>Australian</string> </dict>'
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
}

install_homebrew
install_homebrew_formulas
# install_homebrew_cask
# init_macos
