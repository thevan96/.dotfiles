#!/bin/bash

if [[ `ibus engine | awk -F":" '{ print $2 }'` == "us" ]]; then
  echo 'US'
else
  echo 'VN'
fi
