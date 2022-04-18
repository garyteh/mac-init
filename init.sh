#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

workdir=$(mktemp -d)
log_file="${workdir}/init.log.$(date +%F%T%Z)"

install_homebrew() {
    if ! which brew &> /dev/null; then
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_homebrew_formulas() {
    local installed=$(brew ls -1)

    echo "Installing Homebrew formulas..."
    ! echo "${installed}" | grep -w 'ack' &> /dev/null && brew install 'ack'
    ! echo "${installed}" | grep -w 'apr' &> /dev/null && brew install 'apr'
    ! echo "${installed}" | grep -w 'apr-util' &> /dev/null && brew install 'apr-util'
    ! echo "${installed}" | grep -w 'autoconf' &> /dev/null && brew install 'autoconf'
    ! echo "${installed}" | grep -w 'awscli' &> /dev/null && brew install 'awscli'
    ! echo "${installed}" | grep -w 'bash' &> /dev/null && brew install 'bash'
    ! echo "${installed}" | grep -w 'bash-completion' &> /dev/null && brew install 'bash-completion'
    ! echo "${installed}" | grep -w 'binutils' &> /dev/null && brew install 'binutils'
    ! echo "${installed}" | grep -w 'bzip2' &> /dev/null && brew install 'bzip2'
    ! echo "${installed}" | grep -w 'cassandra' &> /dev/null && brew install 'cassandra'
    ! echo "${installed}" | grep -w 'coreutils' &> /dev/null && brew install 'coreutils'
    ! echo "${installed}" | grep -w 'cython' &> /dev/null && brew install 'cython'
    ! echo "${installed}" | grep -w 'diffutils' &> /dev/null && brew install 'diffutils'
    ! echo "${installed}" | grep -w 'emacs' &> /dev/null && brew install 'emacs'
    ! echo "${installed}" | grep -w 'expect' &> /dev/null && brew install 'expect'
    ! echo "${installed}" | grep -w 'file-formula' &> /dev/null && brew install 'file-formula'
    ! echo "${installed}" | grep -w 'findutils' &> /dev/null && brew install 'findutils'
    ! echo "${installed}" | grep -w 'gawk' &> /dev/null && brew install 'gawk'
    ! echo "${installed}" | grep -w 'gdbm' &> /dev/null && brew install 'gdbm'
    ! echo "${installed}" | grep -w 'gettext' &> /dev/null && brew install 'gettext'
    ! echo "${installed}" | grep -w 'git' &> /dev/null && brew install 'git'
    ! echo "${installed}" | grep -w 'glib' &> /dev/null && brew install 'glib'
    ! echo "${installed}" | grep -w 'gmp' &> /dev/null && brew install 'gmp'
    ! echo "${installed}" | grep -w 'gnu-indent' &> /dev/null && brew install 'gnu-indent'
    ! echo "${installed}" | grep -w 'gnu-sed' &> /dev/null && brew install 'gnu-sed'
    ! echo "${installed}" | grep -w 'gnu-tar' &> /dev/null && brew install 'gnu-tar'
    ! echo "${installed}" | grep -w 'gnu-time' &> /dev/null && brew install 'gnu-time'
    ! echo "${installed}" | grep -w 'gnu-which' &> /dev/null && brew install 'gnu-which'
    ! echo "${installed}" | grep -w 'gnutls' &> /dev/null && brew install 'gnutls'
    ! echo "${installed}" | grep -w 'go' &> /dev/null && brew install 'go'
    ! echo "${installed}" | grep -w 'gpatch' &> /dev/null && brew install 'gpatch'
    ! echo "${installed}" | grep -w 'gradle-completion' &> /dev/null && brew install 'gradle-completion'
    ! echo "${installed}" | grep -w 'grep' &> /dev/null && brew install 'grep'
    ! echo "${installed}" | grep -w 'gzip' &> /dev/null && brew install 'gzip'
    ! echo "${installed}" | grep -w 'htop' &> /dev/null && brew install 'htop'
    ! echo "${installed}" | grep -w 'hub' &> /dev/null && brew install 'hub'
    ! echo "${installed}" | grep -w 'jenv' &> /dev/null && brew install 'jenv'
    ! echo "${installed}" | grep -w 'jq' &> /dev/null && brew install 'jq'
    ! echo "${installed}" | grep -w 'kubernetes-cli' &> /dev/null && brew install 'kubernetes-cli'
    ! echo "${installed}" | grep -w 'kubernetes-helm' &> /dev/null && brew install 'kubernetes-helm'
    ! echo "${installed}" | grep -w 'ldns' &> /dev/null && brew install 'ldns'
    ! echo "${installed}" | grep -w 'less' &> /dev/null && brew install 'less'
    ! echo "${installed}" | grep -w 'libevent' &> /dev/null && brew install 'libevent'
    ! echo "${installed}" | grep -w 'libffi' &> /dev/null && brew install 'libffi'
    ! echo "${installed}" | grep -w 'libidn2' &> /dev/null && brew install 'libidn2'
    ! echo "${installed}" | grep -w 'libmagic' &> /dev/null && brew install 'libmagic'
    ! echo "${installed}" | grep -w 'libpng' &> /dev/null && brew install 'libpng'
    ! echo "${installed}" | grep -w 'libssh2' &> /dev/null && brew install 'libssh2'
    ! echo "${installed}" | grep -w 'libtasn1' &> /dev/null && brew install 'libtasn1'
    ! echo "${installed}" | grep -w 'libunistring' &> /dev/null && brew install 'libunistring'
    ! echo "${installed}" | grep -w 'libyaml' &> /dev/null && brew install 'libyaml'
    ! echo "${installed}" | grep -w 'lua' &> /dev/null && brew install 'lua'
    ! echo "${installed}" | grep -w 'lua@5.1' &> /dev/null && brew install 'lua@5.1'
    ! echo "${installed}" | grep -w 'luarocks' &> /dev/null && brew install 'luarocks'
    ! echo "${installed}" | grep -w 'lynx' &> /dev/null && brew install 'lynx'
    ! echo "${installed}" | grep -w 'lz4' &> /dev/null && brew install 'lz4'
    ! echo "${installed}" | grep -w 'lzip' &> /dev/null && brew install 'lzip'
    ! echo "${installed}" | grep -w 'm4' &> /dev/null && brew install 'm4'
    ! echo "${installed}" | grep -w 'make' &> /dev/null && brew install 'make'
    ! echo "${installed}" | grep -w 'midnight-commander' &> /dev/null && brew install 'midnight-commander'
    ! echo "${installed}" | grep -w 'mpfr' &> /dev/null && brew install 'mpfr'
    ! echo "${installed}" | grep -w 'mysql@5.6' &> /dev/null && brew install 'mysql@5.6'
    ! echo "${installed}" | grep -w 'nano' &> /dev/null && brew install 'nano'
    ! echo "${installed}" | grep -w 'ncurses' &> /dev/null && brew install 'ncurses'
    ! echo "${installed}" | grep -w 'nettle' &> /dev/null && brew install 'nettle'
    ! echo "${installed}" | grep -w 'nvm' &> /dev/null && brew install 'nvm'
    ! echo "${installed}" | grep -w 'oniguruma' &> /dev/null && brew install 'oniguruma'
    ! echo "${installed}" | grep -w 'openssh' &> /dev/null && brew install 'openssh'
    ! echo "${installed}" | grep -w 'openssl' &> /dev/null && brew install 'openssl'
    ! echo "${installed}" | grep -w 'p11-kit' &> /dev/null && brew install 'p11-kit'
    ! echo "${installed}" | grep -w 'pandoc' &> /dev/null && brew install 'pandoc'
    ! echo "${installed}" | grep -w 'parallel' &> /dev/null && brew install 'parallel'
    ! echo "${installed}" | grep -w 'pcre' &> /dev/null && brew install 'pcre'
    ! echo "${installed}" | grep -w 'pcre2' &> /dev/null && brew install 'pcre2'
    if ! echo "${installed}" | grep -w 'perl' &> /dev/null; then
        brew install 'perl'
        PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
    fi
    ! echo "${installed}" | grep -w 'pkg-config' &> /dev/null && brew install 'pkg-config'
    ! echo "${installed}" | grep -w 'pv' &> /dev/null && brew install 'pv'
    ! echo "${installed}" | grep -w 'python' &> /dev/null && brew install 'python'
    # ! echo "${installed}" | grep -w 'python@2' &> /dev/null && brew install 'python@2'
    ! echo "${installed}" | grep -w 'rbenv' &> /dev/null && brew install 'rbenv'
    ! echo "${installed}" | grep -w 'readline' &> /dev/null && brew install 'readline'
    ! echo "${installed}" | grep -w 'redir' &> /dev/null && brew install 'redir'
    ! echo "${installed}" | grep -w 'rename' &> /dev/null && brew install 'rename'
    ! echo "${installed}" | grep -w 'rsync' &> /dev/null && brew install 'rsync'
    ! echo "${installed}" | grep -w 'ruby' &> /dev/null && brew install 'ruby'
    ! echo "${installed}" | grep -w 'ruby-build' &> /dev/null && brew install 'ruby-build'
    ! echo "${installed}" | grep -w 's-lang' &> /dev/null && brew install 's-lang'
    ! echo "${installed}" | grep -w 'screen' &> /dev/null && brew install 'screen'
    ! echo "${installed}" | grep -w 'shellcheck' &> /dev/null && brew install 'shellcheck'
    ! echo "${installed}" | grep -w 'sl' &> /dev/null && brew install 'sl'
    ! echo "${installed}" | grep -w 'sqlite' &> /dev/null && brew install 'sqlite'
    ! echo "${installed}" | grep -w 'subversion' &> /dev/null && brew install 'subversion'
    ! echo "${installed}" | grep -w 'telnet' &> /dev/null && brew install 'telnet'
    ! echo "${installed}" | grep -w 'terraform' &> /dev/null && brew install 'terraform'
    ! echo "${installed}" | grep -w 'tmux' &> /dev/null && brew install 'tmux'
    ! echo "${installed}" | grep -w 'tree' &> /dev/null && brew install 'tree'
    ! echo "${installed}" | grep -w 'unbound' &> /dev/null && brew install 'unbound'
    ! echo "${installed}" | grep -w 'unzip' &> /dev/null && brew install 'unzip'
    ! echo "${installed}" | grep -w 'utf8proc' &> /dev/null && brew install 'utf8proc'
    if ! echo "${installed}" | grep -w 'vim' &> /dev/null; then
        brew install 'vim'
        mkdir -p ~/.vim/bundle/
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        vim +PluginInstall +qall
    fi
    ! echo "${installed}" | grep -w 'watch' &> /dev/null && brew install 'watch'
    ! echo "${installed}" | grep -w 'wdiff' &> /dev/null && brew install 'wdiff'
    ! echo "${installed}" | grep -w 'wget' &> /dev/null && brew install 'wget'
    ! echo "${installed}" | grep -w 'xmlstarlet' &> /dev/null && brew install 'xmlstarlet'
    ! echo "${installed}" | grep -w 'xz' &> /dev/null && brew install 'xz'
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
