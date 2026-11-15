#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
FIT_MODE="cover"
HYPERPAPER_CONFIG="$HOME/.config/hypr/hyprland/hyprpaper.conf"

if [[ ! -d "$WALLPAPER_DIR" ]]; then 
    notify-send "Wallpaper Selector" "Directory not found!"
    exit 1
fi


mapfile -d '' -t WALLPAPERS < <(
    find "$WALLPAPER_DIR" -type f \
        \( -iname '*.jpg' \
        -o -iname '*.jpeg' \
        -o -iname '*.png' \
        -o -iname '*.webp' \) \
        -print0 | sort -z
)


if ((${#WALLPAPERS[@]} == 0)); then
    notify-send "Wallpaper Selector" "No wallpapers found!"
    exit 1
fi

if ! hyprctl hyprpaper listactive >/dev/null 2>&1; then
    hyprctl dispatch exec "hyprpaper --config $HYPERPAPER_CONFIG" >/dev/null 2>&1 || true

    for _ in {1..10}; do
        sleep 0.1
        hyprctl hyprpaper listactive >/dev/null 2>&1 && break
    done
fi

if ! hyprctl hyprpaper listactive >/dev/null 2>&1; then
    notify-send -u critical \
        "Wallpaper Selector" \
        "Hyprpaper could not be started. Check the Hyprpaper configuration."
    exit 1
fi

CURRENT_MONITOR="$(hyprctl monitors -j 2>/dev/null | jq -er '.[] | select(.focused == true) | .name' 2>/dev/null || true)"
if [[ -z "$CURRENT_MONITOR" || "$CURRENT_MONITOR" == "null" ]]; then
    notify-send -u critical "Wallpaper Selector" "Could not find the focused monitor."
    exit 1
fi

SELECTED=$(
    for wallpaper in "${WALLPAPERS[@]}"; do
        relative="${wallpaper#"$WALLPAPER_DIR"/}"
        printf '%s\0icon\x1f%s\n' "$relative" "$wallpaper"
    done | rofi -dmenu \
        -theme "$HOME/.config/hypr/rofi/wallpaper.rasi" \
        -i \
        -show-icons \
        -p "󰸉 Wallpaper" \
        -mesg "Select a wallpaper from your collection"
) || exit 0

[[ -z "$SELECTED" ]] && exit 0

# Resolve selected path
SELECTED="${SELECTED#"$WALLPAPER_DIR"/}"

SELECTED="$WALLPAPER_DIR/$SELECTED"

[[ -f "$SELECTED" ]] || exit 1

if ! hyprctl hyprpaper wallpaper "${CURRENT_MONITOR},${SELECTED},${FIT_MODE}"; then
    notify-send -u critical \
        "Wallpaper Selector" \
        "Hyprpaper is not running or did not accept the wallpaper request."
    exit 1
fi

notify-send \
    -i "$SELECTED" \
    "Wallpaper Changed" \
    "$(basename "$SELECTED")"
