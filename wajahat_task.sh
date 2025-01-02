#!/bin/bash
ps -eo pid,ppid,comm,%cpu --sort=-cpu | head -n 10
