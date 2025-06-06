#!/bin/bash

# (top -b -n 1 | grep "Cpu(s)" | awk '{print $8}' | cut -d '.' -f 1)
cpu_idle=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }')
echo "CPU Usage: ${cpu_usage}"
sleep 1
