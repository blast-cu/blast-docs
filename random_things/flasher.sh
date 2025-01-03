#!/bin/bash
# This script was provided by Aaron Gluck

# This is most useful for locally run programs or those run in an interactive session on CURC
# If you want to know when a program is done at a glance, use this so you don't have to read the terminal

# Recommended usage:
#   <program-to-run> ; sh -e path/to/flasher.sh or alias

# I highly recommend making the file hidden and setting an alias in .bashrc:
#   mv path/to/flasher.sh path/to/.flasher.sh
#   alias flash='sh -e path/to/.flasher.sh'

set -e

trap ctrl_c INT

ctrl_c() {
    printf '\e[?5l'
}

while true; do
    printf '\e[?5h'
    sleep 0.5
    printf '\e[?5l'
    sleep 0.5
done
