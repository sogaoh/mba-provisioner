#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Customize to your needs...

# Iceberg iTerm2 Color
export CLICOLOR=1

# zsh-completion
fpath=(path/to/zsh-completions/src $fpath)

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# goenv
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
export PATH=$HOME/.goenv/bin:$PATH
if command -v goenv 1>/dev/null 2>&1; then
  eval "$(goenv init -)"
fi


# gcloud
export GOOGLE_APPLICATION_CREDENTIALS=$(security find-generic-password -s "gcloud auth path" -w)
export GOOGLE_CREDENTIALS=$(security find-generic-password -s "gcloud auth path" -w)

# az(azure-cli)
export ARM_SUBSCRIPTION_ID=$(security find-generic-password -s "azure subscription id" -w)
export ARM_CLIENT_ID=$(security find-generic-password -s "azure client id" -w)
export ARM_CLIENT_SECRET=$(security find-generic-password -s "azure client secret" -w)
export ARM_TENANT_ID=$(security find-generic-password -s "azure tenant id" -w)

# notion-notes
export NOTION_TOKEN=$(security find-generic-password -s "notion token" -w)
export BLOG_INDEX_ID=$(security find-generic-password -s "notion notes index id" -w)


# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history


# peco
function peco-repos() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-repos
bindkey '^R' peco-repos

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^H' peco-history-selection

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir="$(cdr -l | sed -E 's/^[0-9]+ +//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^F' peco-cdr
#bindkey '^D' peco-cdr

function peco-docker-images() {
  local images="$(docker images | tail +2 | sort | peco --prompt 'DOCKER IMAGES>' | awk '{print $3}' ORS=' ')"
  [ -z "$images" ] && return
  BUFFER="$LBUFFER$images$RBUFFER"
  CURSOR=$#BUFFER
}

zle -N peco-docker-images
bindkey '^x^i' peco-docker-images


# direnv
eval "$(direnv hook zsh)"

# # rbenv -> replaced to anyenv
# export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
# eval "$(rbenv init -)"

# anyenv
eval "$(anyenv init -)"

# for build PHP 7.4, 7.3
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/bzip2/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/tidy-html5/bin:$PATH"
export PATH="/usr/local/opt/libzip/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"

export PHP_RPATHS="/usr/local/opt/openssl/lib:$PHP_RPATHS"
export PHP_RPATHS="/usr/local/opt/bzip2/lib:$PHP_RPATHS"
export PHP_RPATHS="/usr/local/opt/libiconv/lib:$PHP_RPATHS"
export PHP_RPATHS="/usr/local/opt/icu4c/lib:$PHP_RPATHS"
export PHP_RPATHS="/usr/local/opt/tidy-html5/lib:$PHP_RPATHS"
export PHP_RPATHS="/usr/local/opt/libzip/lib:$PHP_RPATHS"
export PHP_RPATHS="/usr/local/opt/libxml2/lib:$PHP_RPATHS"

export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/bzip2/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/libiconv/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/tidy-html5/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/libzip/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"

export PHP_BUILD_CONFIGURE_OPTS="\
  --disable-fpm \
  --disable-phpdbg \
  --enable-debug \
  --with-openssl=/usr/local/opt/openssl \
  --with-bz2=/usr/local/opt/bzip2 \
  --with-iconv=/usr/local/opt/libiconv \
  --with-icu-dir=/usr/local/opt/icu4c \
  --with-tidy=/usr/local/opt/tidy-html5 \
  --with-libzip=/usr/local/opt/libzip \
  --with-libxml-dir=/usr/local/opt/libxml2 \
  --with-zlib \
  --with-zlib-dir=/usr/local/opt/zlib \
  --with-libedit=/usr/local/opt/libedit"
