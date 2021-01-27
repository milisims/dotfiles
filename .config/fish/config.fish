set -x LESS_TERMCAP_mb (printf "\033[01;31m")      # begin blinkin
set -x LESS_TERMCAP_md (printf "\033[01;31m")      # begin bold
set -x LESS_TERMCAP_me (printf "\033[0m")          # end mode
set -x LESS_TERMCAP_se (printf "\033[0m")          # end standout-mode
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")   # begin standout-mode - info box
set -x LESS_TERMCAP_ue (printf "\033[0m")          # end underline
set -x LESS_TERMCAP_us (printf "\033[01;32m")      # begin underline

add_path ~/local/bin
add_path ~/bin
add_path ./node_modules/.bin

fish_vi_key_bindings
