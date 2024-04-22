# Aliases
if command --search eza >/dev/null
    # eza is a modern ls replacement, use it if available
    function ls --description "List contents of directory"
        command eza $argv
    end
end
