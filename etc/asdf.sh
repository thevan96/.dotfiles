#!/bin/bash

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin add java
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
echo 'asdf done!'
