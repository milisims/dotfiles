function fish_prompt --description 'Screen Savvy prompt'
  printf "%s%s%s@%s%s %s%s%s%s%s%s> " \
    (set_color $fish_color_user) $USER (set_color white) \
    (set_color $$fish_color_current_host) (prompt_hostname) \
    (set_color $fish_color_cwd) (prompt_pwd) \
    (set_color $fish_color_host_remote) (fish_git_prompt) \
    (set_color $fish_color_normal)
end
