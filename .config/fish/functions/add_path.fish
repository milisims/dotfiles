function add_path
  contains $argv $fish_user_paths; or set -Ua fish_user_paths $argv
end
