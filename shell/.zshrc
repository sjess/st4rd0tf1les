export ZSH="/home/sjess/.oh-my-zsh"

DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
ZSH_DISABLE_COMPFIX=true

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'

plugins=(git zsh-syntax-highlighting wd git-auto-fetch zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

DEFAULT_USER=$USER

# Set POWERLEVEL9KGT background color, either 'light' or 'dark' (this should match the GNOME Terminal's theme).
POWERLEVEL9KGT_BACKGROUND='dark'
if [[ $POWERLEVEL9KGT_BACKGROUND != 'light' ]] && [[ $POWERLEVEL9KGT_BACKGROUND != 'dark' ]]
then
    POWERLEVEL9KGT_ERROR=true
    echo "POWERLEVEL9KGT error: variable 'POWERLEVEL9KGT_BACKGROUND' should be either 'light' or 'dark'"
fi

# Set POWERLEVEL9KGT color scheme, either 'light', 'dark' or 'bright' (choose by preference).
POWERLEVEL9KGT_COLORS='bright'
if [[ $POWERLEVEL9KGT_COLORS != 'light' ]] && [[ $POWERLEVEL9KGT_COLORS != 'dark' ]] && [[ $POWERLEVEL9KGT_COLORS != 'bright' ]]
then
    POWERLEVEL9KGT_ERROR=true
    echo "POWERLEVEL9KGT error: variable 'POWERLEVEL9KGT_COLORS' should be either 'light', 'dark' or 'bright'"
fi

# Set POWERLEVEL9KGT fonts mode, either 'default', 'awesome-fontconfig', 'awesome-mapped-fontconfig', 'awesome-patched', 'nerdfont-complete' or 'nerdfont-fontconfig'.
# https://github.com/bhilburn/powerlevel9k/wiki/About-Fonts
POWERLEVEL9KGT_FONTS='nerdfont-complete'
if [[ $POWERLEVEL9KGT_FONTS != 'default' ]] && [[ $POWERLEVEL9KGT_FONTS != 'awesome-fontconfig' ]] && [[ $POWERLEVEL9KGT_FONTS != 'awesome-mapped-fontconfig' ]] &&
    [[ $POWERLEVEL9KGT_FONTS != 'awesome-patched' ]] && [[ $POWERLEVEL9KGT_FONTS != 'nerdfont-complete' ]] && [[ $POWERLEVEL9KGT_FONTS != 'nerdfont-fontconfig' ]]
then
    POWERLEVEL9KGT_ERROR=true
    echo "POWERLEVEL9KGT error: variable 'POWERLEVEL9KGT_FONTS' should be either 'default', 'awesome-fontconfig', 'awesome-mapped-fontconfig', 'awesome-patched', 'nerdfont-complete' or 'nerdfont-fontconfig'"
else
    POWERLEVEL9K_MODE=$POWERLEVEL9KGT_FONTS
fi

if [[ $POWERLEVEL9KGT_ERROR != true ]]
then

    # Set POWERLEVEL9KGT background color
    if [[ $POWERLEVEL9KGT_BACKGROUND == 'light' ]]
    then
        # https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#light-color-theme
        POWERLEVEL9K_COLOR_SCHEME='light'
        POWERLEVEL9KGT_TERMINAL_BACKGROUND=231
    elif [[ $POWERLEVEL9KGT_BACKGROUND == 'dark' ]]
    then
        POWERLEVEL9K_COLOR_SCHEME='dark'
        POWERLEVEL9KGT_TERMINAL_BACKGROUND=236
    fi

    # Set POWERLEVEL9KGT foreground colors
    if [[ $POWERLEVEL9KGT_COLORS == 'light' ]]
    then
        POWERLEVEL9KGT_RED=009
        POWERLEVEL9KGT_GREEN=010
        POWERLEVEL9KGT_YELLOW=011
        POWERLEVEL9KGT_BLUE=012
    elif [[ $POWERLEVEL9KGT_COLORS == 'dark' ]]
    then
        POWERLEVEL9KGT_RED=001
        POWERLEVEL9KGT_GREEN=002
        POWERLEVEL9KGT_YELLOW=003
        POWERLEVEL9KGT_BLUE=004
    elif [[ $POWERLEVEL9KGT_COLORS == 'bright' ]]
    then
        POWERLEVEL9KGT_RED=196
        #POWERLEVEL9KGT_GREEN=148
        POWERLEVEL9KGT_GREEN=154
        POWERLEVEL9KGT_YELLOW=220
        POWERLEVEL9KGT_BLUE=075
    fi

    # Customize prompt
    # https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#adding-newline-before-each-prompt
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    # https://github.com/bhilburn/powerlevel9k/tree/next#customizing-prompt-segments
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status root_indicator time context dir_writable dir vcs ssh)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(node_version laravel_version root_indicator background_jobs)

    # Set 'context' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/context/README.md
    POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND

    # Set 'dir_writable' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir_writable/README.md
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$POWERLEVEL9KGT_RED

    # Set 'dir' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir/README.md
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_HOME_FOREGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_ETC_FOREGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=014
    POWERLEVEL9K_DIR_HOME_BACKGROUND=014
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=014
    POWERLEVEL9K_DIR_ETC_BACKGROUND=014

    # Set 'vcs' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/vcs/README.md
    POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$POWERLEVEL9KGT_GREEN
    POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_VCS_CLOBBERED_FOREGROUND=$POWERLEVEL9KGT_RED
    POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$POWERLEVEL9KGT_GREEN
    POWERLEVEL9K_VCS_CLEAN_BACKGROUND=239
    POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=239
    POWERLEVEL9K_VCS_CLOBBERED_BACKGROUND=239
    POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=239

    # Set 'status' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/status/README.md
    POWERLEVEL9K_STATUS_CROSS=true
    POWERLEVEL9K_STATUS_OK_FOREGROUND=$POWERLEVEL9KGT_GREEN
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$POWERLEVEL9KGT_RED
    POWERLEVEL9K_STATUS_OK_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND

    # Set 'root_indicator' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/root_indicator/README.md
    POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND=$POWERLEVEL9KGT_YELLOW
    POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND

    POWERLEVEL9K_TIME_FOREGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_TIME_BACKGROUND=230

    # Set 'background_jobs' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/background_jobs/README.md
    POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$POWERLEVEL9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=$POWERLEVEL9KGT_YELLOW

    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
fi

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

. $HOME/.dotfiles/shell/z.sh

# Sudoless npm https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="~/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export DOCKER_HOST=tcp://localhost:2375