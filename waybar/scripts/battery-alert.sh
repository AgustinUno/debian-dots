#!/usr/bin/env bash
export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)

LOW_THRESHOLD=25      # Set this to the % when you want to be notified
CRITICAL_THRESHOLD=10 # Critical warning level

BAT_PATH=$(upower -e | grep BAT | head -n 1)
# BATTERY_LEVEL=$(upower -i "$BAT_PATH" | awk '/percentage:/ {print $2}' | tr -d '%')
BATTERY_LEVEL=${BATTERY_LEVEL:-$(upower -i "$BAT_PATH" | awk '/percentage:/ {print $2}' | tr -d '%')}

BATTERY_STATUS=$(upower -i "$BAT_PATH" | awk '/state:/ {print $2}')

if [[ "$BATTERY_STATUS" == "discharging" ]]; then
  if [[ "$BATTERY_LEVEL" -le "$CRITICAL_THRESHOLD" ]]; then
    notify-send -u critical "⚠ Battery Critically Low!" "Battery is at $BATTERY_LEVEL%. Plug in your charger NOW!" -i battery-empty
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
  elif [[ "$BATTERY_LEVEL" -le "$LOW_THRESHOLD" ]]; then
    notify-send -u normal "🔋 Battery Low" "Battery is at $BATTERY_LEVEL%. Consider charging soon." -i battery-caution
  fi
fi
