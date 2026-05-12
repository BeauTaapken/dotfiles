#!/usr/bin/env bash
#START=`date +%s`
#while [ $(( $(date +%s) - 40 )) -lt $START ]; do
#    hyprctl dispatch dpms off
#done


# Multi-monitor display power manager

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/display-power"
LOCKFILE="/tmp/display-power-lock"
WAKE_FIFO="/tmp/display-power-wake"

# Configuration - which monitors to control?
# Set to "all" or specific names like "DP-1 HDMI-A-1"
MONITORS="${MONITORS:-all}"  # Override with env var if needed

# Get list of enabled outputs
get_outputs() {
    if [ "$MONITORS" = "all" ]; then
        # All connected outputs
        wlr-randr | grep -e "^[^[:space:]]\+" | cut -d " " -f 1
    else
        # Specific monitors only
        echo "$MONITORS" | tr ' ' '\n'
    fi
}

# Get outputs that are currently ON
get_enabled_outputs() {
    for o in $(get_outputs); do
        if wlr-randr | grep -A 5 "^$o" | grep -q "enabled: yes"; then
            echo "$o"
        fi
    done
}

# Get outputs that are currently OFF
get_disabled_outputs() {
    for o in $(get_outputs); do
        if wlr-randr | grep -A 5 "^$o" | grep -q "enabled: no"; then
            echo "$o"
        fi
    done
}

# Turn displays off
off() {
    local targets="$1"
    [ -z "$targets" ] && targets="$(get_outputs)"
    
    for o in $targets; do
        wlr-randr --output "$o" --off 2>/dev/null
        echo "  → Turned OFF: $o"
    done
}

# Turn displays on
on() {
    local targets="$1"
    [ -z "$targets" ] && targets="$(get_outputs)"
    
    for o in $targets; do
        wlr-randr --output "$o" --on 2>/dev/null
        wlr-randr --output "$o" --mode preferred 2>/dev/null
        echo "  → Turned ON: $o"
    done
}

# Toggle a specific monitor
toggle() {
    local monitor="$1"
    if [ -z "$monitor" ]; then
        # Toggle all
        off
        sleep 0.2
        on
    else
        # Toggle specific monitor
        if wlr-randr | grep -A 5 "^$monitor" | grep -q "enabled: yes"; then
            off "$monitor"
        else
            on "$monitor"
        fi
    fi
}

# Power save mode - turn off secondary monitors only
powersave() {
    echo "Entering power save mode..."
    local primary="$(get_outputs | head -1)"  # Usually DP-1 or eDP-1
    
    for o in $(get_outputs); do
        if [ "$o" != "$primary" ]; then
            off "$o"
        fi
    done
    echo "  → Secondary monitors OFF"
    echo "  → Primary monitor ($primary) staying ON"
}

# Restore all monitors
restore() {
    echo "Restoring all monitors..."
    on
}

# Idle mode - smart multi-monitor idle
idle() {
    # Prevent multiple instances
    if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
        echo "Already running (PID $(cat "$LOCKFILE"))"
        exit 1
    fi
    echo $$ > "$LOCKFILE"
    
    # Create FIFO for wake signaling
    rm -f "$WAKE_FIFO"
    mkfifo "$WAKE_FIFO"
    
    # Remember which monitors were on
    local enabled_before="$(get_enabled_outputs | tr '\n' ' ')"
    echo "Saving enabled monitors: $enabled_before"
    
    # Turn ALL displays off
    off
    
    # Wait for input in background
    (
        if command -v evtest &> /dev/null; then
            timeout 3600 evtest --grab /dev/input/event* 2>/dev/null | head -n1 > /dev/null
        else
            while true; do
                if read -t 0 -n 1; then break; fi
                if [ -r /dev/input/mice ] && read -t 1 -n 1 < /dev/input/mice 2>/dev/null; then break; fi
                sleep 0.1
            done
        fi
        echo "wake" > "$WAKE_FIFO"
    ) &
    
    MONITOR_PID=$!
    
    # Wait for wake signal
    read -t 3600 -r signal < "$WAKE_FIFO"
    
    # Cleanup
    kill $MONITOR_PID 2>/dev/null
    rm -f "$WAKE_FIFO" "$LOCKFILE"
    
    # Restore only the monitors that were on before
    echo "Restoring monitors: $enabled_before"
    on "$enabled_before"
    
    exit 0
}

# Status with multi-monitor details
status() {
    echo "=== Display Power Status ==="
    echo "Monitors configured: $(get_outputs | tr '\n' ' ')"
    echo ""
    
    for o in $(get_outputs); do
        local state="OFF"
        if wlr-randr | grep -A 5 "^$o" | grep -q "enabled: yes"; then
            state="ON"
            local mode=$(wlr-randr | grep -A 5 "^$o" | grep "mode:" | head -1 | awk '{print $2}')
            echo "  ✓ $o: $state ($mode)"
        else
            echo "  ✗ $o: $state"
        fi
    done
    
    if pgrep -f "display-power idle" > /dev/null; then
        echo ""
        echo "🔒 Idle mode active (displays off, waiting for input)"
    fi
}

# Command dispatch
case "$1" in
    off) off "$2" ;;
    on) on "$2" ;;
    toggle) toggle "$2" ;;
    idle) idle ;;
    powersave) powersave ;;
    restore) restore ;;
    status) status ;;
    *)
        echo "Usage: display-power {off|on|toggle|idle|powersave|restore|status} [monitor]"
        echo ""
        echo "Examples:"
        echo "  display-power off              → Turn off all monitors"
        echo "  display-power off DP-1         → Turn off only DP-1"
        echo "  display-power on HDMI-A-1      → Turn on only HDMI-A-1"
        echo "  display-power idle             → All off, wake on any input"
        echo "  display-power powersave        → Keep primary, turn off secondary"
        echo "  display-power status           → Show current state"
        echo ""
        echo "Environment variables:"
        echo "  MONITORS='DP-1 HDMI-A-1'       → Control specific monitors only"
        exit 1
        ;;
esac
