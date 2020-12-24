function fish_mode_prompt
  echo '['
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo 'n'
    case insert
      set_color --bold brgreen
      echo 'i'
    case replace_one
      set_color --bold green
      echo 'r'
    case replace
      set_color --bold green
      echo 'R'
    case visual
      set_color --bold brmagenta
      echo 'v'
    case '*'
      set_color --bold red
      echo $fish_bind_mode
  end
  set_color normal
  echo '] '
end

