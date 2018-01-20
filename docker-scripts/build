#!/usr/bin/env bash

# https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
# CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu || echo "$NUMBER_OF_PROCESSORS")
CORES=$(grep -c ^processor /proc/cpuinfo)
scons all --disable-warnings-as-errors -j ${CORES} --ssl
