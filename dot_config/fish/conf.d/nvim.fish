# Neovim shortcuts that don't shadow the real vim/vi/view commands.
# Guarded so machines without nvim are unaffected.
if type -q nvim
    abbr -a v nvim
    abbr -a nv 'nvim -R'
end
