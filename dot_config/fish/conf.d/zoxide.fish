# zoxide — smarter cd that jumps to frecent directories (`z <query>`, `zi <query>`).
# Guarded so machines without zoxide are unaffected.
if type -q zoxide
    zoxide init fish | source
end
