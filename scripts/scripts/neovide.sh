#!/usr/bin/env bash

export NVIM_APPNAME="nvim-blaze"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

exec "$HOME/Downloads/Neovide/neovide.AppImage" \
  --neovim-bin /opt/nvim-linux-x86_64/bin/nvim
  
