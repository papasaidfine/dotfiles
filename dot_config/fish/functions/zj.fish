# Attach to (or create) a zellij session named "$USER@<host alias>", so the machine
# is identifiable in zellij's status bar (session name) and the outer terminal title.
function zj --description 'Zellij session named user@host-alias'
    zellij attach --create "$USER@"(__host_alias)
end
