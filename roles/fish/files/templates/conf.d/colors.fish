# =====================================
#         Syntax highlighting
# =====================================
# {{ "{{{" }}

# These colors are used for syntax highlighting the text shown on the command
# line.

# For normal text, use the default terminal style.
set fish_color_normal normal

# Commands and executables.
set fish_color_command magenta

# Command parameters (e.g. most of the line after a command)
set fish_color_param blue

# Auto suggestion text after the cursor when typing a command.
set fish_color_autosuggestion brblack

# Errors such as incorrect commands while typing, or the status prompt after
# a non-zero exit code of the previous command.
set fish_color_error red

# the color for the '^C' indicator on a canceled command
set fish_color_cancel --reverse

# Text between any kind of quotes
set fish_color_quote green

# the color used for code comments
set fish_color_comment e7c547

# All operators are given the same color:
# - Process separators (e.g. `;` and `&`)
# - Parameter expansion operators (e.g. `*` and `~`)
# - IO redirection
set fish_color_end bryellow
set fish_color_operator bryellow
set fish_color_redirection bryellow

# the color used to highlight matching parenthesis
set fish_color_match --background=brblue

# the color used when selecting text (in vi visual mode)
set fish_color_selection white --bold --background=brblack

# used to highlight history search matches and the selected pager item (must be a background)
set fish_color_search_match bryellow --background=brblack

# the color used to highlight character escapes like '\n' and '\x70'
set fish_color_escape bryellow --bold
# {{ "}}}" }}

# =====================================
#                Prompt
# =====================================
# {{ "{{{" }}

# Colors for the prompt
set fish_color_user brgreen
set fish_color_host normal
set fish_color_cwd green
set __fish_git_prompt_color_branch yellow
# {{ "}}}" }}

# =====================================
#           Completion pager
# =====================================
# {{ "{{{" }}

# Additionally, the following variables are available to change the highlighting in the completion pager:

# the color of the prefix string i.e. the string that is to be completed
set fish_pager_color_prefix green --bold

# the color of the completion itself
set fish_pager_color_completion normal

# the color of the completion description
set fish_pager_color_description yellow

# the color of the progress bar at the bottom left corner
set fish_pager_color_progress brwhite --background=cyan

# the background color of the every second completion
set fish_pager_color_secondary normal
# {{ "}}}" }}


set fish_color_history_current --bold
set fish_color_status red
set fish_color_valid_path --underline
