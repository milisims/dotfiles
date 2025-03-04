function uvenv -a cmd name
  if test -z $cmd
    echo "Usage: uvenv [create|activate|remove] ..."
    return
  end

  switch $cmd
    case "create"
      set env_path $HOME/.local/share/venv/$name/bin
      uv venv $env_path --seed
      echo (set_color $fish_color_venv) "Created $name at '$env_path'"

      source $HOME/.local/share/venv/$name/bin/activate.fish
      echo (set_color $fish_color_param) "Activated $name"

      if set -q argv[2]
        echo -n (set_color $fish_color_comment)
        pip install $argv[2..-1]
        echo (set_color $fish_color_host) "Installed $argv[2..-1]"
      end
      echo -n (set_color $fish_color_normal)

    case "pick"
      ls $HOME/.local/share/venv | fzf_pipe | read -l name
      if test -n $name
        emit _uv_activate $name
      end

    case "list"
      for venv in (ls $HOME/.local/share/venv)
        if test $venv = $VIRTUAL_ENV_PROMPT
          echo -e (set_color $fish_color_param)"> $venv"(set_color $fish_color_normal)
        else
          echo "  $venv"
        end
      end

    case "activate"
      # see conf.d/uv_env.fish
      emit _uv_activate $name

    case "remove"
      if test "$VIRTUAL_ENV_PROMPT" = "$name"
        emit _uv_activate base
      end
      rm -rf $HOME/.local/share/venv/$name
      echo (set_color $fish_color_param) "Removed $name"

    case "*"
      echo "Usage: uvenv [create|activate|remove] ..."
      return
  end
end
