# 启动时自动 source venv
if status --is-interactive
    if test -n "$VIRTUAL_ENV"
        source $VIRTUAL_ENV/bin/activate.fish
    else
        if test -f venv/bin/activate.fish
            source venv/bin/activate.fish
        end
    end
end