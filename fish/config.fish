set -g fish_greeting ""
set -gx NVIM_LISTEN_ADDRESS "/tmp/nvimsocket_$fish_pid"

if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) > /dev/null
    ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end
