#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "usage: $0 <monitor>"
fi

# the single quotes are neccessary to prevent command substitution
trap 'kill $(jobs -p)' SIGTERM EXIT

monitor="$1"
display=$(echo "$DISPLAY" | tr -d ':')
fifo="/tmp/polybar-${display}.${monitor}-stdin.fifo"
[ -p "$fifo" ] || mkfifo "$fifo"

MONITOR="$monitor" STDINFIFO="$fifo" polybar xmonad-stdin &

# wait for polybar reader to start
while ! pgrep -axf "cat ${fifo}"; do : ; done

# refresh xmonad to display polybar correctly
bin/launch client refresh &

cat > "$fifo"
