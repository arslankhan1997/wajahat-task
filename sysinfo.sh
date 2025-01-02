#!/bin/bash
{
echo "the host name is: $(hostname)"
echo "the time and date is: $(date)"
echo "the current kernel version is: $(uname -r)"
echo "memory information: $(free -h)"
} > system_info.txt