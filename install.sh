#!/usr/bin/env bash
PERSONAL_PACKAGES="nvim wezterm zsh git karabiner borders zed"
WORK_PACKAGES="nvim wezterm karabiner borders zed"

case "$1" in
  personal) packages=$PERSONAL_PACKAGES ;;
  work)     packages=$WORK_PACKAGES ;;
  *)        echo "Usage: $0 [personal|work]"; exit 1 ;;
esac

cd "$(dirname "$0")"
stow $packages
