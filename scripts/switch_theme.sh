#!/bin/bash

MODE=$1  # "dark" or "light"

if [ "$MODE" == "dark" ]; then
    echo "Switching to dark theme..."

    cp "$HOME/dotfiles/alacritty/alacritty-dark.toml" "$HOME/.alacritty.toml"
    tmux source-file "$HOME/dotfiles/tmux/themes/dark.conf"
    cp "$HOME/dotfiles/nvim/lua/theme-dark.lua" "$HOME/dotfiles/nvim/lua/theme.lua"
    ln -sf "$HOME/.config/eza-themes/themes/tokyonight.yml" "$HOME/.config/eza/theme.yml"

elif [ "$MODE" == "light" ]; then
    echo "Switching to light theme..."

    cp "$HOME/dotfiles/alacritty/alacritty-light.toml" "$HOME/.alacritty.toml"
    tmux source-file "$HOME/dotfiles/tmux/themes/light.conf"
    cp "$HOME/dotfiles/nvim/lua/theme-light.lua" "$HOME/dotfiles/nvim/lua/theme.lua"
    ln -sf "$HOME/.config/eza-themes/themes/default.yml" "$HOME/.config/eza/theme.yml"
else
    echo "Usage: $0 [dark|light]"
    exit 1
fi
