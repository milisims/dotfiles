set -x LESS_TERMCAP_mb (printf "\033[01;31m")      # begin blinkin
set -x LESS_TERMCAP_md (printf "\033[01;31m")      # begin bold
set -x LESS_TERMCAP_me (printf "\033[0m")          # end mode
set -x LESS_TERMCAP_se (printf "\033[0m")          # end standout-mode
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")   # begin standout-mode - info box
set -x LESS_TERMCAP_ue (printf "\033[0m")          # end underline
set -x LESS_TERMCAP_us (printf "\033[01;32m")      # begin underline

abbr --add l 'ls -lh'
abbr --add la 'ls -Alh'
abbr --add lx 'ls -lXh'
abbr --add lt 'ls -lth'
abbr --add lm 'ls -lh | more'
abbr --add cl 'clear; ls -lh'
abbr --add cls 'clear; ls'
abbr --add grep 'grep --color=auto'
abbr --add fg 'fg'
abbr --add md 'mkdir -p'
abbr --add rd 'rmdir'
abbr --add which 'type -a'
abbr --add d cdh
abbr --add path 'string replace --all : \n "$PATH"'
abbr --add du 'du -sh'
abbr --add crontab 'VIM_CRONTAB=true crontab'
abbr --add nev 'nvim'
abbr --add nevs 'nvim -S Session.vim'
abbr --add vims 'vim -S Session.vim'
abbr --add please 'sudo'
abbr --add np 'numpy'
abbr --add wget 'wget'
abbr --add tls 'tmux ls'
abbr --add tns 'tmux new -s'
abbr --add tat 'tmux attach -t'
abbr --add org 'nvim +OrgAgenda'

abbr --add gst 'git status'
abbr --add cst 'clear; git status'
abbr --add gpl 'git pull'
abbr --add gpu 'git push'
abbr --add gad 'git add'
abbr --add gap 'git add --patch'
abbr --add gau 'git add --update'
abbr --add gaup 'git add --update --patch'
abbr --add gd 'git diff'
abbr --add gwd 'git diff --color-words'
abbr --add grh 'git reset HEAD --'
abbr --add gcim 'git commit -m'
abbr --add gbr 'git branch'
abbr --add gco 'git checkout'
abbr --add glo 'git log --all --oneline --decorate --graph -n 20'

# config defined in functions
abbr --add cost 'config status'
abbr --add cpl 'config pull'
abbr --add cpu 'config push'
abbr --add cad 'config add'
abbr --add cap 'config add --patch'
abbr --add cau 'config add --update'
abbr --add caup 'config add --update --patch'
abbr --add cdf 'config diff'
abbr --add crh 'config reset HEAD --'
abbr --add ccim 'config commit -m'
abbr --add cbr 'config branch'
abbr --add cco 'config checkout'
abbr --add clo 'config log --all --oneline --decorate --graph -n 20'

abbr --add pd prevd
abbr --add nd nextd

function add_path
  contains $argv $fish_user_paths; or set -Ua fish_user_paths $argv
end

add_path ~/local/bin
add_path ~/bin

fish_vi_key_bindings
