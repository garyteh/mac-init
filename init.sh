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

brew install apr \
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
    unzip \
    utf8proc \
    vim \
    watch \
    wdiff \
    wget \
    xmlstarlet \
    xz 