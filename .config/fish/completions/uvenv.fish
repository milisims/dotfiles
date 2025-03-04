function __complete_venvs
  for venv in (ls $HOME/.local/share/venv)
    set _pyenv $HOME/.local/share/venv/$venv/pyvenv.cfg
    if test -f $_pyenv
      set _version "python=$(grep version_info $_pyenv | cut -d' ' -f3)"
    end
    echo $venv\t$_version
  end
end

complete -f -c uvenv
complete -f -c uvenv -n '__fish_use_subcommand' -a create -d "Create a new uv venv"
complete -f -c uvenv -n '__fish_use_subcommand' -a activate -d "Activate an existing uv venv"
complete -f -c uvenv -n '__fish_use_subcommand' -a remove -d "Remove an existing uv venv"
complete -f -c uvenv -n '__fish_use_subcommand' -a list -d "List all uv venvs"
complete -f -c uvenv -n '__fish_use_subcommand' -a pick -d "Pick an existing uv venv with fzf"
complete -f -c uvenv -n '__fish_seen_subcommand_from activate remove' -a "(__complete_venvs)"
