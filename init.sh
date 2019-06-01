#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

workdir=$(mktemp -d)
log_file="${workdir}/init.log.$(date +%F%T%Z)"
exec 19>>"${log_file}"
export BASH_XTRACEFD="19"

set -x

function __debug {
    [[ ! -z "${current_command+x}" ]] && last_command=${current_command}
    current_command=${BASH_COMMAND}
}
trap __debug DEBUG

function __exit {
    last_command_exit_code=$?
    if [[ ${last_command_exit_code} -ne 0 ]] && [[ ${last_command_exit_code} -ne 130 ]]; then
        echo "ERROR (${last_command_exit_code}): ${last_command}"
    fi
}
trap __exit EXIT

function __sigint {
    echo
    printf "%-30s: %-10s\n" "Last command" "${last_command}"
    exit 130
}
trap __sigint SIGINT

echo "Log @ ${LOG_FILE}"

if [[ ! -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]; then
    echo "Installing Xcode Command Line Tool..."
    touch "/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
    softwareupdate -i "$PROD"
fi

if ! which brew &> /dev/null; then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing Homebrew formulas..."
brew install ack \
    apr \
    apr-util \
    autoconf \
    awscli \
    bash \
    bash-completion \
    binutils \
    cassandra \
    coreutils \
    cython \
    diffutils \
    emacs \
    expect \
    file-formula \
    findutils \
    gawk \
    gdbm \
    gettext \
    git \
    glib \
    gmp \
    gnu-indent \
    gnu-sed \
    gnu-tar \
    gnu-time \
    gnu-which \
    gnutls \
    go \
    gpatch \
    gradle-completion \
    grep \
    gzip \
    htop \
    hub \
    jenv \
    jq \
    kubernetes-cli \
    kubernetes-helm \
    ldns \
    less \
    libevent \
    libffi \
    libidn2 \
    libmagic \
    libpng \
    libssh2 \
    libtasn1 \
    libunistring \
    libyaml \
    lua \
    lua@5.1 \
    luarocks \
    lynx \
    lz4 \
    lzip \
    m4 \
    make \
    midnight-commander \
    mpfr \
    mysql@5.6 \
    nano \
    ncurses \
    nettle \
    nvm \
    oniguruma \
    openssh \
    openssl \
    p11-kit \
    pandoc \
    parallel \
    pcre \
    pcre2 \
    perl \
    pkg-config \
    pv \
    python \
    rbenv \
    readline \
    rename \
    rsync \
    ruby \
    ruby-build \
    s-lang \
    screen \
    shellcheck \
    sqlite \
    subversion \
    telnet \
    terraform \
    tmux \
    tree \
    unbound \
    unzip \
    utf8proc \
    vim \
    watch \
    wdiff \
    wget \
    xmlstarlet \
    xz 

echo "Homebrew formula post installations..."
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib

echo "Set up vundle for vim..."
mkdir -p ~/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing application using brew-cask..."
brew cask install google-chrome \
    android-file-transfer \
    appcleaner \
    authy \
    docker \
    dropbox \
    fluor \
    iina \
    iterm2 \
    lastpass \
    spotify \
    sublime-text \
    visual-studio-code \
    intellij-idea \
    whatsapp 

defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '{"Bundle ID" = "com.apple.inputmethod.TCIM"; InputSourceKind = "Keyboard Input Method";}'
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '{"Bundle ID" = "com.apple.inputmethod.ChineseHandwriting"; InputSourceKind = "Non Keyboard Input Method";}'