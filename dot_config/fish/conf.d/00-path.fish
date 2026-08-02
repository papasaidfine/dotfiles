# User-installed binaries. bash gets this from ~/.profile, which fish never
# reads, so it must be added here explicitly.
#
# fish sources conf.d snippets in alphabetical order, so this file is named to
# sort first: mise.fish, nvim.fish and friends all guard on `type -q <tool>`,
# and those tools live in the directories added below. Named `path.fish` it
# sorted *after* mise.fish, so in any fish session started before
# $fish_user_paths had been populated, mise was not on PATH yet, the guard
# failed, and no mise-managed tool got exposed. Keep this sorting first.
if test -d ~/.local/bin
    fish_add_path ~/.local/bin
end

# Add Cargo's bin directory to PATH when present
if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end
