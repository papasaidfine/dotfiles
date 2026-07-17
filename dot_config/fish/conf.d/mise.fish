# Expose mise-managed tools (installed by scripts/install_apps.sh).
# Guarded so machines without mise are unaffected.
if type -q mise
    mise activate fish | source
end
