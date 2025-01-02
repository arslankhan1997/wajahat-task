#!/bin/bash
echo "enter name"
read username
if id "$username" &>/dev/null; then
user_home=$(getent passwd "$username" | cut -d: -f6)
user_shell=$(getent passwd "$username" | cut -d: -f7)
echo "$username exists"
echo "$user_home"
echo "$user_shell"
else
echo "$username doesnot exist"
sudo useradd "$username"

fi
