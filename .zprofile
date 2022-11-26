de=$XDG_CURRENT_DESKTOP

if [[ $de == 'i3' ]]; then
  # Setup keychain for SSH without gnome-keyring
  eval `keychain --eval --agents ssh id_rsa_github_personal`
  clear
fi
