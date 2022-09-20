#!/bin/bash

docker compose up -d

# open the browser window
PORT=5050
xdg-open http://localhost:$PORT
