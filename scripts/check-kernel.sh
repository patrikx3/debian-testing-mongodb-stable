#!/usr/bin/env bash
# check if we are root
sudo bash -c 'clear && echo && echo MongoDB: && cat /var/log/mongodb/mongodb.log | grep Kernel | tail -1 | cut -d \" -f16 && echo && echo System: && uname -r && echo'