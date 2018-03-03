#!/usr/bin/env bash
# check if we are root
sudo bash -c 'clear && echo && echo MongoDB: && cat /var/log/mongodb/mongodb.log | grep -i version | tail -1 | cut -d \" -f12 && echo && echo System: && uname -r && echo'