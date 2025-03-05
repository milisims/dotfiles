function __activate_event --on-event _uv_activate -a name
  if __env_ready $name
    __env_select $name
  end
end

function __auto_base --on-event fish_postexec -d "Activate base venv if necessary"
  if not set -q VIRTUAL_ENV
    __env_select base
    set -g _auto_venv base
  end
end

function __auto_venv_selection --on-event fish_prompt -d "Auto-select project venv if appropriate"
  set -l project (string match -rg 'Projects/([^/]+)' (pwd))
  if test -z "$project"
    or test "$project" = "$_auto_venv"
    return
  end

  set -l path (string match -rg '(.*/Projects/[^/]+)' (pwd))
  if test -d $path/.venv
    source $path/.venv/bin/activate.fish
    printf "== Activated .venv in %s%s%s\n" (set_color green) $project (set_color normal)
  else if __env_ready $project
    __env_select $project
    printf "== Activated %s(%s)%s\n" (set_color green) $project (set_color normal)
  else if __env_ready (string lower $project)
    __env_select (string lower $project)
    printf "== Activated %s(%s)%s\n" (set_color green) $project (set_color normal)
  else
    return
  end
  set -g _auto_venv $project

end

# helpers
function __env_select -a project
  source ~/.local/share/venv/$project/bin/activate.fish
end

function __env_ready -a name
  test -d "$HOME/.local/share/venv/$name"
  and test -f "$HOME/.local/share/venv/$name/bin/activate.fish"
  and test "$_auto_venv" != "$name"
  return $status
end
