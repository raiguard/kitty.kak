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

