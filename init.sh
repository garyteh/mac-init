#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

WORKDIR=$(mktemp -d)
LOG_FILE="${WORKDIR}/init.log.$(date +%F%T%Z)"
ECHO_PATH=$(which echo)
RED='\033[0;31m'
NC='\033[0m'

echo "Log: ${LOG_FILE}"

echo() {
    $ECHO_PATH "$@"
    $ECHO_PATH "$@" > "$LOG_FILE"
}

stderr() {
    $ECHO_PATH "$@" > "$LOG_FILE"
    >&2 $ECHO_PATH -e "${RED}${@}${NC}"
    return 1
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
    echo "Installing Homebrew casks..."
    brew install --cask 'android-file-transfer' \
'appcleaner' \
'authy' \
'docker' \
'dropbox' \
'fluor' \
'google-chrome' \
'iina' \
'iterm2' \
'spotify' \
'sublime-text' \
'whatsapp' > "${LOG_FILE}"
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

setup_default_shell() {
    local file="/etc/shells" path="/usr/local/bin/bash"

    if [[ -a "$path" ]]; then
        if ! cat "${file}" | grep -E "^${path}\$" &> /dev/null; then
            echo "Updating ${file}..."
            $ECHO_PATH "${path}" | sudo tee -a "${file}"
        fi
        if ! echo "$SHELL" | grep "${path}" &> /dev/null; then
            echo "Set default shell as ${path}..."
            chsh -s "${path}"
        fi
    else
        stderr "$path not found..."
    fi
}

post_brew_formulas() {
    setup_default_shell
}

install_homebrew
install_homebrew_formulas
install_homebrew_cask
post_brew_formulas
# init_macos
