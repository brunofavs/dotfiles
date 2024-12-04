# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Including the .conf file directly in kitty. This method has lag
# (cat ~/.cache/wal/sequences &)

# --------------------
# Environment Variables
# --------------------
#
# PATH Variable

# Adding Script folder to path
PATH=$PATH:"$HOME/Scripts"

#Necessary to run zoxide binary in ubuntu
PATH=$PATH:"$HOME/.local/bin"

export PATH

#export VISUAL=vim
export VISUAL=nvim
export EDITOR="$VISUAL"
export FILE_MANAGER="thunar"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# export LIBVA_DRIVER_NAME=nvidia
# export XDG_SESSION_TYPE=wayland
# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export WLR_NO_HARDWARE_CURSORS=1 

# Telling Hyprland which GPU to use
# https://wiki.hyprland.org/Configuring/Multi-GPU/
export AQ_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"
export HYPRSHOT_DIR="$HOME/Pictures/Screenshots"
export XDG_CURRENT_DESKTOP=gnome


ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(copypath
zsh-autosuggestions
zsh-syntax-highlighting
zsh-vi-mode
git
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc_functions

# Aliasese

alias ROS_classes="cd ~/catkin_ws/src/ROS_mess_arround"
alias automec="cd ~/catkin_ws/src/AutoMec-AD/"
alias c="clear"
#Uninstalled rn
#alias matlab="/usr/local/MATLAB/R2023b/bin/matlab"
alias 5.1="cd $HOME/Documents/University/5.1"
alias nvim_swap="cd ~/.local/state/nvim/swap/"
alias vim="nvim"
alias vi="nvim"
alias thesis="$HOME/Tese/thesis_document/document/"

alias ementas="docker run --ipc=host --network host --rm gribeiro00/ementas_ua:1.0 ementas"
alias battery_status="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias buds_status="upower -i /org/freedesktop/UPower/devices/headset_dev_0C_8D_CA_5B_30_00"

#------------------------
#  Functions 
#------------------------

open() {
    if [[ -z "$1" || "$1" == "." ]]; then
      $FILE_MANAGER &>/dev/null & disown
    else
      for file in "$@"; do
        echo "Opening $file"
        xdg-open "$file" &>/dev/null & disown
     done
    fi
}

test-microphone() {
    arecord -vvv -f dat /dev/null
}

remove-whitespaces(){
  for x in *" "*; do
    mv -- "$x" "${x// /_}"
  done
}


#------------------------
#  Virtualenvwrapper 
#------------------------
#
export WORKON_HOME=$HOME/.virtualenvs
# source /usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh

#----------------------
#      ROS
#---------------------

#----------------------
#    ROS WORKSPACES
#---------------------

#----------------------
#    ATOM
#---------------------

alias atom="cd $HOME/atom_ws/src/atom"

export ROS_BAGS="$HOME/bagfiles"
export ATOM_DATASETS="$HOME/datasets"
export ATOM_EXPERIMENTS="$HOME/atom_experiments"


#----------------------
#      CLI Tools
#---------------------

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
# if [ "$(lsb_release -ds)" = "Arch Linux" ]; then
eval "$(fzf --zsh)"
# fi

# -- Use fd instead of fzf --

setup_fzf fd

# GH GB GH GB
KEYTIMEOUT=10
source ~/Scripts/fzf-git.sh/fzf-git.sh

# ---- BAT -----

alias cat="bat"

alias ls="eza --icons=always"


# if grep -q '^ID=arch' /etc/os-release; then
  # alias cd="z"
  eval "$(zoxide init --cmd cd zsh)"
# fi

#----------------------
#      DISTROBOX
#---------------------
# Fix big processes crashing container
ulimit -Hn 524288

if [ "$(lsb_release -ds)" = "Ubuntu 20.04.6 LTS" ]; then
    source ~/.zshrc_ubuntu
fi

# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/bruno/.dart-cli-completion/zsh-config.zsh ]] && . /home/bruno/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

