# Attach to (or create) a zellij session named "$USER@<host alias>", so the machine
# is identifiable in zellij's status bar (session name) and the outer terminal title.
#
# --forget discards any serialized snapshot of a *closed* (exited) session of the same
# name before connecting, so re-running `zj` after closing all tabs starts a fresh
# session instead of resurrecting the old tabs/cwds/commands. A running or detached
# session isn't affected (its state lives in the zellij server), so reattach still works.
function zj --description 'Zellij session named user@host-alias'
    zellij attach --create --forget "$USER@"(__host_alias)
end
