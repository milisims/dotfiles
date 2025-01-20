# conda is slow to setup/ init, and part of why is because it creates a script to execute.
# The primary point of this script is to create an async setup to create the file, and
# update it if necessary. Then automatically change envs based on project.

# In subshells, path gets wonky, Fixes it more or less
if set -q CONDA_PREFIX
  fish_add_path -g {$_CONDA_ROOT}/condabin
  fish_add_path -g {$CONDA_PREFIX}/bin
end
if not set -q _CONDA_CFG
  set -g _CONDA_CFG (dirname (status -f))/_conda_setup.fish
  set -g _CONDA_CFG_UPDATE (dirname (status -f))/_conda_setup.new.fish
end


# This function sets up the async check against the old file.
# Sourcing it is fast, so it's just created into the conf.d fish dir.
function __setup_conda --on-event compute_conda_setup -d "Async conda setup file creation"
  # emitted in config.fish
  set -l fname $argv[1]
  set -l cmd $argv[2..-1]
  if not set -q CONDASETUP
    # creates a fish subshell to create the new conda setup file
    # the bash ... & lets all this work
    bash -c "export CONDASETUP=1; fish -c 'emit _verify $fname ($argv[2..-1])' &"
  end
end

function __check_conda_setup --on-event _verify -d "Update conda setup file if necessary"
  set -l fname $argv[1]
  if not test -f $_CONDA_CFG
    mv $fname $_CONDA_CFG
  else if not diff -q $_CONDA_CFG $fname > /dev/null 2>&1
    # When this is set, fish_right_prompt will display a notification
    mv $fname $_CONDA_CFG_UPDATE
  end
end

function update-conda
  if not test -f $_CONDA_CFG_UPDATE
    return
  end
  diff -p $_CONDA_CFG $_CONDA_CFG_UPDATE
  printf "\n%sOriginal%s --- %sNew%s\n" (set_color red) (set_color normal) (set_color green) (set_color normal)

  while true
    set -g fish_mode_hide  # prevents fish_mode_prompt
    read -l -n 1 confirm -p "echo -n 'Update conda setup file? [Y/n] '; set_color normal"
    if test $status -ne 0
      return  # break on ctrl-c
    end
    switch $confirm
      case '' y Y
        mv $_CONDA_CFG_UPDATE $_CONDA_CFG
        break
      case n N
        break
    end
  end

end

# Usually, this sets up the env right away on first command. But will 'wait'
# for conda setup to update the file otherwise.
function __auto_conda_base --on-event fish_preexec -d "Activate conda base env if necessary"
  if not set -q CONDA_SHLVL
    if not test -f $_CONDA_CFG
      return
    end
    source $_CONDA_CFG
    __fix_conda_prompt
  end

  if test $CONDA_SHLVL -eq 0
    and not conda activate base
    set -g _FAILED_CONDA_ACTIVATION
  end

  set -g _auto_conda_selected_env $CONDA_DEFAULT_ENV
end

function __auto_conda_env_selection --on-event fish_prompt -d "Auto-select conda env if appropriate"
  if test -z $CONDA_PREFIX
    return
  end

  set -l project (string match -rg 'Projects/([^/]+)' (pwd))
  if test -z "$project"
    return
  end

  if __env_exists $project
    __env_select $project
  else if __env_exists (string lower $project)
    __env_select (string lower $project)
  end

end

# helpers
function __env_select -a project
  while [ "$CONDA_DEFAULT_ENV" != "base" ]
    conda deactivate
  end
  if conda activate $project
    set -g _auto_conda_selected_env $project
    printf "== Activated %s(%s)%s\n" (set_color green) $project (set_color normal)
  else
    printf "== Failed to activate %s(%s)%s\n" (set_color $fish_color_error) $project (set_color normal)
  end
end

function __env_exists -a project
  test -d "$_CONDA_ROOT/envs/$project"
  and [ "$_auto_conda_selected_env" != "$project" ]
  and [ "$_auto_conda_selected_env" = $CONDA_DEFAULT_ENV ]
  return $status
end

function _fish_right_prompt
  set -f text (set_color normal)
  if test -f $_CONDA_CFG_UPDATE
    set -a text (set_color $fish_color_error) "[update-conda]"
  end

  if set -q _FAILED_CONDA_ACTIVATION
    set -a text (set_color --bold $fish_color_error) "(!)"
  else if not set -q CONDA_SHLVL  # cheat - not actiavted yet but it will be
    or test "$CONDA_SHLVL" -eq 0
    set -a text (set_color --bold $fish_color_conda_env) "(base)"
  else if set -q CONDA_DEFAULT_ENV  # from __conda_add_prompt
    set -a text (set_color --bold $fish_color_conda_env) "($CONDA_DEFAULT_ENV)"
  end

  set -a text (set_color normal) " "
  if test (count $text) -gt 3
    echo -n (string join '' $text)
  end
end

# conda takes this over, I'm taking it back
function __fix_conda_prompt
  if functions -q fish_right_prompt
      functions -e fish_right_prompt
  end
  functions -c _fish_right_prompt fish_right_prompt
end

__fix_conda_prompt
