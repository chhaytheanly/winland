#!/usr/bin/env bash

mode="${1:-poll}"

show_center() {
    local list
    list=$(makoctl list 2>/dev/null | jq -r '.. | .summary?.text?, .body?.text?' 2>/dev/null | grep -v '^null$' | grep -v '^$' | paste -sd' | ')
    if [[ -z "$list" ]]; then
        list=$(makoctl history 2>/dev/null | jq -r '.. | .summary?.text?, .body?.text?' 2>/dev/null | grep -v '^null$' | grep -v '^$' | paste -sd' | ')
    fi
    if [[ -z "$list" ]]; then
        rofi -dmenu -p "Notifications" -no-input -no-custom \
            -theme-str 'window { width: 30%; } listview { lines: 1; }' \
            <<< "No notifications"
        return
    fi
    local chosen
    chosen=$(printf "%s\n" "$list" | rofi -dmenu -p "Notifications" \
        -theme-str 'window { width: 30%; } listview { lines: 10; spacing: 6px; }')
    if [[ -n "$chosen" ]]; then
        makoctl dismiss -a 2>/dev/null
    fi
}

if [[ "$mode" == "center" ]]; then
    show_center
    exit 0
fi

while true; do
    count=$(makoctl list 2>/dev/null | jq '[.. | objects | select(has("summary"))] | length' 2>/dev/null)
    if [[ -z "$count" || "$count" -eq 0 ]]; then
        printf '{"text":" 󰂚 ", "class":"nopending", "tooltip":"No notifications"}\n'
    else
        printf '{"text":" 󰂛 %s", "class":"pending", "tooltip":"%s notification(s)"}\n' "$count" "$count"
    fi
    sleep 2
done
