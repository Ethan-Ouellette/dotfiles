
# Disable Python / Conda prompt pollution
export VIRTUAL_ENV_DISABLE_PROMPT=1

ssh_identity() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "%F{cyan}%n@%m%f "
  fi
}

setopt PROMPT_SUBST
PROMPT='$(ssh_identity)%F{blue}%~%f %# '

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ethan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ethan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ethan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ethan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# conda activate weather312

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Applications/MATLAB_R2024a.app/bin/maci64

export MADIS_STATIC=~/madis/static
export MADIS_DATA=~/madis_data
export TOP=~/madis
export NCDF=/opt/homebrew  # Adjust based on netCDF installation path
export NETCDF_INCLUDE="/opt/homebrew/opt/netcdf-fortran/include"
export NETCDF_LDFLAGS_F="/opt/homebrew/opt/netcdf-fortran/lib -lnetcdff -lnetcdf"
export IFC="gfortran"
export IFFLAGS="-O2 -finit-local-zero -g -fbacktrace"


# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

export PATH=/usr/local/smlnj/bin:"$PATH"

export PATH="$HOME/.local/bin:$PATH"
