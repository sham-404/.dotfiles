#!/bin/bash
alacritty -o 'window.startup_mode="Fullscreen"' -e tmux new-session -A -s main "fastfetch; exec zsh"
