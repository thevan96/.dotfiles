#!/usr/bin/env bash

pip install -U pip
pip install -U pynvim
pip install -U httpie
pip install -U sqlfluff
pip install -U httpie

npm install -g npm@latest
npm install -g neovim
npm install -g prettier
npm install -g standard
npm install -g kill-port
npm install -g browser-sync
npm install -g pyright
npm install -g typescript
npm install -g sass

go install github.com/editorconfig-checker/editorconfig-checker/cmd/editorconfig-checker@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/gopls@latest

rustup component add rust-analyzer
cargo install stylua

asdf reshim nodejs
asdf reshim python
asdf reshim rust
asdf reshim golang
