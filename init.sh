#!/usr/bin/env bash

set -euo pipefail

readonly LOG_FILE="/var/log/init.log"
touch "$LOG_FILE"

exec > >(tee -a "$LOG_FILE") 2>&1

if [[ ! -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]; then
    echo "Installing Xcode Command Line Tool..."
    touch "/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
    softwareupdate -i "$PROD" -v
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