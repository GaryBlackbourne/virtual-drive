set -l commands 'create' 'delete' 'mount' 'unmount' 'list' 'version' 'help'

# disable file completions
complete -c virtual-drive -f

# add help and version commands as flags
complete -c virtual-drive -s v -l 'version'
complete -c virtual-drive -s h -l 'help'

complete -c virtual-drive -n "not __fish_seen_subcommand_from $commands" \
    -a "$commands"

complete -c virtual-drive -n "__fish_seen_subcommand_from create" \
    -a '__fish_complete_directory'

complete -c virtual-drive -n "__fish_seen_subcommand_from delete" \
    -a '(virtual-drive list | awk \'{ print $1 }\')'

complete -c virtual-drive -n "__fish_seen_subcommand_from mount" \
    -a '(virtual-drive list | grep -E "not mounted" | awk \'{ print $1 }\')'

complete -c virtual-drive -n "__fish_seen_subcommand_from unmount" \
    -a '(virtual-drive list | grep -E ":: mounted" | awk \'{print $1}\')'

