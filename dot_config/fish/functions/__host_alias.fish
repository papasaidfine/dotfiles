# Print this machine's display name: the first line of ~/.config/host-alias if that
# file exists and is non-empty (a friendly name you write yourself, per machine),
# otherwise the short hostname.
function __host_alias --description 'User-defined host alias, or short hostname'
    if test -s ~/.config/host-alias
        read -l alias <~/.config/host-alias
        echo $alias
    else
        prompt_hostname
    end
end
