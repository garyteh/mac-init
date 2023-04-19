#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

if [[ -t 1 ]]; then
    tty_escape() { printf "\033[%sm" "$1"; }
else
    tty_escape() { :; }
fi

tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_yellow="$(tty_mkbold 33)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
    local arg
    printf "%s" "$1"
    shift
    for arg in "$@"; do
        printf " "
        printf "%s" "${arg// /\ }"
    done
}

chomp() {
    printf "%s" "${1/"$'\n'"/}"
}

abort() {
    printf "%s\n" "$@" >&2
    printf "${tty_red}Error${tty_reset}: %s\n" "$(shell_join "$@")" >&2
    exit 1
}

warn() {
    printf "${tty_yellow}Warning${tty_reset}: %s\n" "$(chomp "$1")" >&2
}

ohai() {
    printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

tmp_workdir=$(mktemp -d) || abort "Unable to create temporary work directory."

ohai "Created a temporary directory @ ${tmp_workdir}."
ohai "Get ready to enter your password for super access."
sudo -v

warn "Keeping your sudo session active in background"
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done &> /dev/null &

if [[ ! -z "${SKIP_INSTALL_HOMEBREW-}" ]]; then
    ohai "Installing Homebrew."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    warn "Skip installing homebrew."
fi

if [[ ! -z "${SKIP_INSTALL_HOMEBREW_DEPENDENCIES-}" ]]; then
    if [[ ! -x "$(command -v brew)" ]]; then
        ohai "Sourcing \`brew\` to current TTY."
        if [[ -x "/opt/homebrew/bin/brew" ]]; then
            # On ARM macOS, this script installs to /opt/homebrew only
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x "/usr/local/bin/brew" ]]; then
            # On Intel macOS, this script installs to /usr/local only
            eval "$(/usr/local/bin/brew shellenv)"
        else
            abort "Homebrew is not installed."
        fi
    fi

    ohai "Downloading Brewfile from GitHub."
    brewfile_path="${WORKDIR}/Brewfile"
    curl -o "${brewfile_path}" https://raw.githubusercontent.com/garyteh/mac-init/master/Brewfile

    ohai "Installing all Homebrew dependencies."
    brew bundle install --file "${brewfile_path}" -v
else
    warn "Skip installing Homebrew dependencies."
fi

if [[ ! -z "${SKIP_SETUP_DEFAULT_SHELL-}" ]]; then
    shells_path="/etc/shells" 
    bash_exec_pathes=$(which -a bash | grep -vFx '/bin/bash')

    if [[ $(echo "${bash_exec_pathes}" | wc -l) -eq 0 ]]; then
        abort "No additional \`bash\` found. Try \`brew install bash\`."
    elif [[ $(echo "${bash_exec_pathes}" | wc -l) -gt 1 ]]; then
        abort "Multiple \`bash\` found:
${bash_exec_pathes}
Manual intervention required to update ${shells_path}."
    fi
    if ! cat "${shells_path}" | grep -Fx "${bash_exec_pathes}" &> /dev/null; then
        ohai "Adding ${bash_exec_pathes} to ${shells_path}."
        echo "${bash_exec_pathes}" | sudo tee -a "${shells_path}"
    fi
    if ! echo "$SHELL" | grep "${bash_exec_pathes}" &> /dev/null; then
        ohai "Setting default shell as ${bash_exec_pathes}."
        chsh -s "${bash_exec_pathes}"
    fi
else
    echo "Skip setting up default shell."
fi

if [[ ! -z "${SKIP_INSTALL_POWERLINE_GO-}" ]]; then
    if [[ ! -x "$(command -v go)" ]]; then
        abort "\`go\`: command not found. Try \`brew install go\`."
    fi
    if [[ ! -x "$(command -v git)" ]]; then
        abort "\`git\`: command not found. Try \`brew install git\`."
    fi
    if [[ ! -x "${HOME}/.go/bin/powerline-go" ]]; then
        ohai "Installing powerline-go."
        GOPATH="${HOME}/.go/" go install github.com/justjanne/powerline-go@latest
    fi
    if ! ls "${HOME}/Library/Fonts" | grep -iw powerline &> /dev/null; then
        echo "Installing powerline-fonts."
        git clone https://github.com/powerline/fonts.git "${tmp_workdir}/fonts"
        "${tmp_workdir}/fonts/install.sh"
    fi
else
    echo "Skip installing powerline-go."
fi

# manage macOS preferences
# if [[ ! -z "${SKIP_SETUP_MACOS_PREFERENCES-}" ]]; then
#     defaults write NSGlobalDomain KeyRepeat -int 2
#     defaults write NSGlobalDomain InitialKeyRepeat -int 15
#     defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
#     defaults delete com.apple.HIToolbox AppleEnabledInputSources
#     defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>InputSourceKind</key> <string>Keyboard Layout</string> <key>KeyboardLayout ID</key> <integer>15</integer> <key>KeyboardLayout Name</key> <string>Australian</string> </dict>'
#     defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.TCIM</string> <key>Input Mode</key> <string>com.apple.inputmethod.TCIM.Pinyin</string> <key>InputSourceKind</key> <string>Input Mode</string> </dict>'
#     defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.TCIM</string> <key>InputSourceKind</key> <string>Keyboard Input Method</string> </dict>'
#     defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.ChineseHandwriting</string> <key>InputSourceKind</key> <string>Non Keyboard Input Method</string> </dict>'    
#     defaults delete com.apple.HIToolbox AppleInputSourceHistory
#     defaults write com.apple.HIToolbox AppleInputSourceHistory -array-add '<dict> <key>InputSourceKind</key> <string>Keyboard Layout</string> <key>KeyboardLayout ID</key> <integer>15</integer> <key>KeyboardLayout Name</key> <string>Australian</string> </dict>'
#     defaults write com.apple.HIToolbox AppleInputSourceHistory -array-add '<dict> <key>Bundle ID</key> <string>com.apple.inputmethod.TCIM</string> <key>Input Mode</key> <string>com.apple.inputmethod.TCIM.Pinyin</string> <key>InputSourceKind</key> <string>Input Mode</string> </dict>'
#     defaults delete com.apple.HIToolbox AppleSelectedInputSources
#     defaults write com.apple.HIToolbox AppleSelectedInputSources -array-add '<dict> <key>Bundle ID</key> <string>com.apple.PressAndHold</string> <key>InputSourceKind</key> <string>Non Keyboard Input Method</string> </dict>'
#     defaults write com.apple.HIToolbox AppleSelectedInputSources -array-add '<dict> <key>InputSourceKind</key> <string>Keyboard Layout</string> <key>KeyboardLayout ID</key> <integer>15</integer> <key>KeyboardLayout Name</key> <string>Australian</string> </dict>'
#     defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# else
#     echo "Skip setting up macOS preferences."
# fi

if [[ ! -z "${SKIP_CLONE_DOTFILES-}" ]]; then
    if [[ ! -x "$(command -v git)" ]]; then
        abort "\`git\`: command not found. Try \`brew install git\`."
    fi

    ohai "Cloning dotfiles to ${HOME}."
    git clone --bare https://github.com/garyteh/mac-dotfiles.git "${HOME}/.cfg"
    git --git-dir="${HOME}/.cfg/" --work-tree="${HOME}" checkout
    git --git-dir="${HOME}/.cfg/" --work-tree="${HOME}" config --local status.showUntrackedFiles no
fi 