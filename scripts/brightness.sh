#!/usr/bin/env bash
set -euo pipefail

action="${1:-}"
case "$action" in
  up)
    brightnessctl set +5% >/dev/null
    ;;
  down)
    brightnessctl set 5%- >/dev/null
    ;;
  *)
    exit 0
    ;;
esac

