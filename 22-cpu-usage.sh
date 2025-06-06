#!/bin/bash

    cpu_idle=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $8}' | cut -d '.' -f 1)
    cpu_usage=$((100 - cpu_idle))
    echo "CPU Usage: $cpu_usage%"