# Expose mise-managed tools (installed by scripts/install_apps.sh).
# Depends on ~/.local/bin (where mise itself lives) already being on PATH,
# which 00-path.fish guarantees by sorting first in conf.d.
# Guarded so machines without mise are unaffected.

# Shims work in every context, including non-interactive shells and programs
# launched outside a shell, which never run the activation hook below. Added
# first so `mise activate` prepends the real tool paths ahead of them.
if test -d $HOME/.local/share/mise/shims
    fish_add_path $HOME/.local/share/mise/shims
end

if type -q mise
    mise activate fish | source
end
