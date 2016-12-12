#!/usr/bin/zsh
#------------------------------------------////
# Completion options
#------------------------------------------////
autoload -Uz compinit && compinit

zmodload -i zsh/complist    # colored menu for completion
setopt complete_in_word     # Middle of word completion
setopt always_to_end        # /some[]/here -> /something/here[]
unsetopt menu_complete      # on ambiguious match, don't insert first option

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

# see http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html
#
# Completion options: ignore case, approximately correct, ignore a few
# errors, don't go to menu if unambiguous, but go to menu if ambiguious.
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select
zstyle ':completion:*' original true

# Cache so things like apt and anything on a slow server aren't awful to use
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $HOME/.cache/zsh

# From oh-my-zsh
# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
    clamav colord daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
    gkrellmd gnats gopher hacluster haldaemon halt hplip hsqldb ident irc \
    junkbust kdm kernoops ldap libuuid lightdm lp mail mailman mailnull \
    man messagebus mldonkey mysql nagios named netdump news nfsnobody \
    nobody nscd ntp nut nx obsrun openvpn operator pcap polkitd postfix \
    postgres privoxy proxy pulse pvm quagga radvd rpc rpcuser rpm rtkit \
    saned scard shutdown snmp squid sshd statd svn sync sys syslog tftp \
    usbmux uucp vcsa whoopsie www-data wwwrun xfs '*server' '_*'
zstyle '*' single-ignored show  # ... unless we really want to.

# What does this do?
zstyle :compinstall filename "$HOME/.zshrc"
#
