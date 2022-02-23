#!/bin/bash

if [[ `ibus engine | awk -F":" '{ print $2 }'` == "us" ]]; then
  echo 'US'
  tmux refresh-client -S
else
  echo 'VN'
  tmux refresh-client -S
fi
