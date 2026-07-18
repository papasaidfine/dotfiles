# Attach to (or create) a zellij session named "$USER@<alias>", so the machine is
# identifiable in zellij's status bar (session name) and the outer terminal title.
# Source this from ~/.bashrc:  source ~/.config/bash/zj.bash
#
# <alias> = first line of ~/.config/host-alias (written per machine) or short hostname.
#
# --forget discards any serialized snapshot of a *closed* (exited) session of the same
# name before connecting, so re-running `zj` after closing all tabs starts a fresh
# session instead of resurrecting the old tabs/cwds/commands. A running or detached
# session isn't affected (its state lives in the zellij server), so reattach still works.
zj() {
  local name
  if [ -s "$HOME/.config/host-alias" ]; then
    IFS= read -r name < "$HOME/.config/host-alias"
  else
    name=${HOSTNAME%%.*}
  fi
  zellij attach --create --forget "$USER@$name"
}
