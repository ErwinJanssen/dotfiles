# Insert a new line before displaying the prompt. This separates the command
# prompt from the previous output.
function fishprompt_newline \
    --description "Insert a new line before displaying the prompt." \
    --on-event fish_prompt
    echo
end

# Automatically merge the history after executing a command. This creates
# a global history that is shared between all fish sessions, and prevents
# entries from suddenly being "forgotten".
function global_history \
    --description "Merge history after every command." \
    --on-event fish_prompt
    history merge
end
