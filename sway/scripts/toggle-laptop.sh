#!/usr/bin/env bash
STATE=$(swaymsg -t get_outputs | jq -r '.[] | select(.name=="eDP-1").active')

if [ "$STATE" = "true" ]; then
    swaymsg output eDP-1 disable
else
    swaymsg output eDP-1 enable
fi

