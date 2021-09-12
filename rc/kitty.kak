declare-option -hidden str kitty_kak_source %sh{ echo "${kak_source%/*}" }

define-command kitty-terminal-overlay -params 1.. -shell-completion -docstring '
kitty-terminal <program> [<arguments>]: create a new terminal as a kitty overlay window
The program passed as argument will be executed in the new terminal' \
%{
    nop %sh{
        match=""
        if [ -n "$kak_client_env_KITTY_WINDOW_ID" ]; then
            match="--match=id:$kak_client_env_KITTY_WINDOW_ID"
        fi

        listen=""
        if [ -n "$kak_client_env_KITTY_LISTEN_ON" ]; then
            listen="--to=$kak_client_env_KITTY_LISTEN_ON"
        fi

        kitty @ $listen launch --no-response --type="overlay" --cwd="$PWD" $match "$@"
    }
}

define-command kitty-terminal-fullscreen -params 1.. -shell-completion -docstring '
kitty-terminal <program> [<arguments>]: create a new terminal as a maximized kitty window
Requires that the `stack` layout be enabled in your `kitty.conf`
The program passed as argument will be executed in the new terminal' \
%{
    nop %sh{
        match=""
        if [ -n "$kak_client_env_KITTY_WINDOW_ID" ]; then
            match="--match=id:$kak_client_env_KITTY_WINDOW_ID"
        fi

        listen=""
        if [ -n "$kak_client_env_KITTY_LISTEN_ON" ]; then
            listen="--to=$kak_client_env_KITTY_LISTEN_ON"
        fi

        # FIXME: This crashes kak for some reason!?
        # kitty @ $listen goto-layout stack
        kitty @ $listen launch --no-response --cwd="$PWD" --watcher "$kak_opt_kitty_kak_source/watcher.py" $match "$@"
    }
}

define-command goto-layout-test %sh{
    kitty @ goto-layout stack
}
