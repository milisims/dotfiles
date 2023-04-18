function on_prompt --description 'Do things automatically just before prompts are displayed'
  if not set -q auto_conda
    set -g auto_conda 'base'
    set -g default_conda_prefix $CONDA_PREFIX
  end
  set -l project (string match -rg 'Projects/([^/]+)' (pwd))
  if test -z "$project"
    return
  end

  if test -d $default_conda_prefix/envs/$project
    and [ "$auto_conda" = $CONDA_DEFAULT_ENV ]
    and [ "$auto_conda" != "$project" ]

    while [ "$CONDA_DEFAULT_ENV" != "base" ]
      conda deactivate
    end
    set -g auto_conda $project
    conda activate $project
    echo "== Auto conda activated '$project'"
    echo -ns (fish_mode_prompt)
  end


end
