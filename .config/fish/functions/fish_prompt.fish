function fish_prompt --description 'Screen Savvy prompt'
  printf '%s%s%s@%s%s %s%s%s%s%s%s> ' (set_color yellow) $USER (set_color white) (set_color purple) (prompt_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color blue) (fish_git_prompt) (set_color normal)
end
