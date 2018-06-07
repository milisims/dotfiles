#!/usr/bin/zsh
#------------------------------------------////
# History & general
#------------------------------------------////
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history       # add history entries as they are used
setopt inc_append_history   # as above, per line
# setopt share_history        # can use fc -RI instead, maybe?
setopt extended_history     # store date and duration
setopt hist_ignore_dups     # replace older dups with newer executions
setopt hist_ignore_space    # ignore ' cmd' from history
setopt hist_verify          # allow editing of line after history expansion

setopt interactive_comments # allow comments in interactive shells

# Allow more globbing, and if there's no match let user know
setopt extendedglob nomatch
unsetopt beep

# auto pushd on cd
# Useful with aliasing .=popd
# . can just act as a "back" button
setopt pushd_silent auto_pushd pushd_ignore_dups

# disable ^S/^Q for flow control
setopt noflowcontrol

#------------------------------------------////
# Bindings
#------------------------------------------////

# Allow for vim-mode. -e for emacs.
bindkey -v
bindkey -M viins 'jk'    vi-cmd-mode

# But we still want normal cli binds
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line

# ssh <C-n> searches commands beginning with ssh.
bindkey -M viins '^n'    history-beginning-search-forward
bindkey -M viins '^p'    history-beginning-search-backward

# and regular function keys to work.
bindkey -M viins "^[[1~" vi-beginning-of-line   # Home
bindkey -M viins "^[[4~" vi-end-of-line         # End
bindkey -M viins '^[[2~' beep                   # Insert
bindkey -M viins '^[[3~' delete-char            # Del
bindkey -M vicmd "^[[1~" vi-beginning-of-line
bindkey -M vicmd "^[[4~" vi-end-of-line
bindkey -M vicmd '^[[2~' beep

autoload zmv  # zmv with no clargs shows example usage

# Mmm. Vim.
export EDITOR=$(command -v vim)
export VISUAL=$(command -v vim)

#------------------------------------------////
# Paths
#------------------------------------------////

function addpath() {
  local newpath=$1
  if [[ ! "$PATH" == *${newpath}* ]] && [[ -d $newpath ]]; then
    echo $(readlink -f $newpath):$PATH
  else
    echo $PATH
  fi
}

export PATH=$(addpath "$HOME/.local/bin")
export PATH=$(addpath "$HOME/miniconda3/bin")
export PATH=$(addpath "$HOME/local/bin")
export PATH=$(addpath "$HOME/.scripts/bin")

#------------------------------------------////
# fzf
#------------------------------------------////

# must be after vi mode declaration!
if [[ -d "$HOME/local/src/fzf" ]]; then
  fzf-history-widget-to-ins() {
    zle fzf-history-widget
    zle vi-end-of-line
    zle vi-insert
  }
  zle -N fzf-history-widget-to-ins
  bindkey -M vicmd '/' fzf-history-widget-to-ins

  [[ $- == *i* ]] && source "$HOME/local/src/fzf/shell/completion.zsh" 2> /dev/null
  source "$HOME/local/src/fzf/shell/key-bindings.zsh"
fi

#------------------------------------------////
# Color man pages
#------------------------------------------////

export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinkin
export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'          # end mode
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'          # end underline
export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline

#------------------------------------------////
# Aliases
#------------------------------------------////
if [[ -f $HOME/.alias ]]; then
    source $HOME/.alias
fi

if [[ -f $HOME/.local/dot/alias ]]; then
    source $HOME/.local/dot/alias
fi

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
#
