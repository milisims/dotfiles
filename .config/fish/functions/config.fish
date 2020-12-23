function config --wraps='git' --description 'git for HOME config'
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv;
end
