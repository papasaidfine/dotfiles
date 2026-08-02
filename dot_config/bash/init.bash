# Loads every snippet in this directory, in sorted order.
#
# This is bash's stand-in for ~/.config/fish/conf.d, which fish sources on its
# own. bash has no such directory, so without this loader (wired into ~/.bashrc
# by the modify_dot_bashrc script) the snippets here are inert files — which is
# why mise never activated under bash and nothing it installs, fish and nvim
# included, showed up on PATH.
#
# Sorted order matters: mise.bash comes first, and the snippets after it guard
# on tools that only exist once mise has put them on PATH.
_bash_snippet_dir=${BASH_SOURCE[0]%/*}
for _bash_snippet in "$_bash_snippet_dir"/*.bash; do
  [ "$_bash_snippet" = "${BASH_SOURCE[0]}" ] && continue
  [ -r "$_bash_snippet" ] && . "$_bash_snippet"
done
unset _bash_snippet_dir _bash_snippet
