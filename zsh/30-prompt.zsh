#!/usr/bin/zsh
autoload -Uz colors && colors

source ${0:a:h}/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1

setopt prompt_subst
PROMPT='
%{%B%F{blue}%}#%{%f%b%} \
%(#,%{%K{yellow}%F{black}%n%k%f%},%F{cyan}%n%f) \
%{%F{white}%}@ \
%{%F{green}%}%m \
%{%F{white}%}in \
%{%B%F{yellow}%}%~%{%f%b%} \
$(__git_ps1 "%%F{white}on%%f git:%s ")\
%{%F{white}%}[%*] \
%(?,,C:%{%F{red}%}%?%{%f%})
%{%B%F{red}%}$%{%f%b%} %{$reset_color%}'
#
