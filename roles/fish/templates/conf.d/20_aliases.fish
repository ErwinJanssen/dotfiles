# Aliases
if command --search exa >/dev/null
    # exa is a modern ls replacement, use it if available
    function ls --description "List contents of directory"
        command exa $argv
    end
end
