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
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" &> "${LOG_FILE}"
    fi
}

install_homebrew_formulas() {
    echo "Installing Homebrew formulas..."
    brew install \
'ack' \
'adns' \
'aom' \
'apr' \
'apr-util' \
'aribb24' \
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
'cjson' \
'cloudflared' \
'cmocka' \
'coreutils' \
'curl' \
'cython' \
'dav1d' \
'diffutils' \
'docker-compose' \
'docutils' \
'emacs' \
'expect' \
'fasd' \
'ffmpeg' \
'file-formula' \
'findutils' \
'flac' \
'fontconfig' \
'freetype' \
'frei0r' \
'fribidi' \
'fzf' \
'gawk' \
'gd' \
'gdbm' \
'gdk-pixbuf' \
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
'gpatch' \
'gradle' \
'gradle-completion' \
'graphite2' \
'graphviz' \
'grep' \
'gts' \
'guile' \
'gzip' \
'harfbuzz' \
'helm' \
'highway' \
'htop' \
'httpie' \
'hub' \
'icu4c' \
'imath' \
'jansson' \
'jasper' \
'jemalloc' \
'jenv' \
'jpeg' \
'jpeg-turbo' \
'jpeg-xl' \
'jq' \
'kubernetes-cli' \
'lame' \
'lastpass-cli' \
'ldns' \
'leptonica' \
'less' \
'libarchive' \
'libass' \
'libassuan' \
'libavif' \
'libb2' \
'libbluray' \
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
'liblinear' \
'libmagic' \
'libnghttp2' \
'libogg' \
'libpng' \
'libpthread-stubs' \
'librist' \
'librsvg' \
'libsamplerate' \
'libsndfile' \
'libsodium' \
'libsoxr' \
'libssh2' \
'libtasn1' \
'libtiff' \
'libtool' \
'libunibreak' \
'libunistring' \
'libusb' \
'libuv' \
'libvidstab' \
'libvmaf' \
'libvorbis' \
'libvpx' \
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
'little-cms2' \
'lua' \
'lua@5.1' \
'lua@5.3' \
'luarocks' \
'lynx' \
'lz4' \
'lzip' \
'lzo' \
'm4' \
'make' \
'mbedtls' \
'midnight-commander' \
'moreutils' \
'mpdecimal' \
'mpfr' \
'mpg123' \
'mvnvm' \
'mysql@5.6' \
'nano' \
'ncurses' \
'netcat' \
'netpbm' \
'nettle' \
'nghttp2' \
'nmap' \
'node' \
'npth' \
'nvm' \
'oniguruma' \
'opa' \
'opencore-amr' \
'openexr' \
'openjdk' \
'openjdk@11' \
'openjdk@8' \
'openjpeg' \
'openldap' \
'openssh' \
'openssl@1.1' \
'openssl@3' \
'opus' \
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
'python@3.11' \
'python@3.8' \
'python@3.9' \
'qrencode' \
'qt@5' \
'rav1e' \
'rbenv' \
'readline' \
'redir' \
'redis' \
'rename' \
'rsync' \
'rtmpdump' \
'rubberband' \
'ruby' \
'ruby-build' \
's-lang' \
'screen' \
'sdl2' \
'shellcheck' \
'six' \
'sl' \
'snappy' \
'speex' \
'sqlite' \
'srt' \
'subversion' \
'svt-av1' \
'tcl-tk' \
'telnet' \
'terraform' \
'tesseract' \
'thefuck' \
'theora' \
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
'x264' \
'x265' \
'xmlstarlet' \
'xorgproto' \
'xvid' \
'xxhash' \
'xz' \
'yarn' \
'yq' \
'zeromq' \
'zimg' \
'zlib' \
'zsh-autosuggestions' \
'zsh-completions' \
'zstd' &> "${LOG_FILE}"
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
'whatsapp' &> "${LOG_FILE}"
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
    local file="/etc/shells" exe_path="/usr/local/bin/bash"

    if [[ -a "${exe_path}" ]]; then
        if ! cat "${file}" | grep -E "^${exe_path}\$" &> /dev/null; then
            echo "Updating ${file}..."
            $ECHO_PATH "${exe_path}" | sudo tee -a "${file}"
        fi
        if ! echo "$SHELL" | grep "${exe_path}" &> /dev/null; then
            echo "Set default shell as ${exe_path}..."
            chsh -s "${exe_path}"
        fi
    else
        stderr "${exe_path} not found..."
    fi
}

install_powerline_go() {
    if [[ ! -a "${HOME}/.go/bin/powerline-go" ]]; then
        echo "Installing powerline-go..."
        GOPATH="${HOME}/.go/" go install github.com/justjanne/powerline-go@latest &> "${LOG_FILE}"
    fi
    if ! ls "${HOME}/Library/Fonts" | grep -iw powerline &> /dev/null; then
        echo "Installing powerline-fonts..."
        git clone https://github.com/powerline/fonts.git "${WORKDIR}/fonts" &> "${LOG_FILE}"
        "${WORKDIR}/fonts/install.sh" &> "${LOG_FILE}"
    fi
}

post_brew_formulas() {
    setup_default_shell
    install_powerline_go
}

install_homebrew
install_homebrew_formulas
install_homebrew_cask
post_brew_formulas
# init_macos
