# Attach to (or create) a zellij session named "$USER@<alias>", so the machine is
# identifiable in zellij's status bar (session name) and the outer terminal title.
#
# <alias> = first line of ~/.config/host-alias (written per machine) or short hostname.
zj() {
  local name
  if [ -s "$HOME/.config/host-alias" ]; then
    IFS= read -r name < "$HOME/.config/host-alias"
  else
    name=${HOSTNAME%%.*}
  fi
  zellij attach --create "$USER@$name"
}
