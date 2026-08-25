set -g fish_greeting ""
set -gx NVIM_LISTEN_ADDRESS "/tmp/nvimsocket_$fish_pid"
if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end
