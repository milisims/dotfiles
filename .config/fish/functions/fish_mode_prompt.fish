function fish_mode_prompt
  echo '['
  switch $fish_bind_mode
    case default
      set_color --bold $fish_color_vimode_normal
      echo 'n'
    case insert
      set_color --bold $fish_color_vimode_insert
      echo 'i'
    case replace_one
      set_color --bold $fish_color_vimode_replace_one
      echo 'r'
    case replace
      set_color --bold $fish_color_vimode_replace
      echo 'R'
    case visual
      set_color --bold $fish_color_vimode_visual
      echo 'v'
    case '*'
      set_color --bold red
      echo $fish_bind_mode
  end
  set_color normal
  echo '] '
end

