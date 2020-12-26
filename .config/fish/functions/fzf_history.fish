# From https://github.com/junegunn/fzf/blob/e9bc733/shell/key-bindings.fish
function fzf_history -d "Show command history"
  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m"

    set -l FISH_MAJOR (echo $version | cut -f1 -d.)
    set -l FISH_MINOR (echo $version | cut -f2 -d.)

    # history's -z flag is needed for multi-line support.
    # history's -z flag was added in fish 2.4.0, so don't use it for versions
    # before 2.4.0.
    if [ "$FISH_MAJOR" -gt 2 -o \( "$FISH_MAJOR" -eq 2 -a "$FISH_MINOR" -ge 4 \) ];
      history -z | eval (__fzfcmd) --read0 --print0 -q '(commandline)' | read -lz result
      and commandline -- $result
    else
      history | eval (__fzfcmd) -q '(commandline)' | read -l result
      and commandline -- $result
    end
  end
  commandline -f repaint
end

function __fzfcmd
  test -n "$FZF_TMUX"; or set FZF_TMUX 0
  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  if [ -n "$FZF_TMUX_OPTS" ]
    echo "fzf-tmux $FZF_TMUX_OPTS -- "
  else if [ $FZF_TMUX -eq 1 ]
    echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
  else
    echo "fzf"
  end
end
