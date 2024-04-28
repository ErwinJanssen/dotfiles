{
  enable = true;
  settings = {
    character = {
      success_symbol = "[»](default)";
      error_symbol = "[»](red)";
    };
    directory = {
      fish_style_pwd_dir_length = 1;
      style = "green";
    };

    git_branch = {
      format = "[$symbol$branch]($style) ";
      style = "purple";
    };

    git_status = {
      format = "([\\[]($style)[$ahead_behind](yellow)[|]($style)$all_status[\\]]($style) )";
      behind = "↓$count";
      ahead = "↑$count";
      diverged = "↑$ahead_count↓$behind_count";
      conflicted = "[✘$count](red)";
      up_to_date = "[✓](green)";
      untracked = "[?$count](default)";
      stashed = "[\\$$count](default)";
      modified = "[~$count](yellow)";
      staged = "[+$count](green)";
      renamed = "[»$count](yellow)";
      deleted = "[-$count](red)";
      style = "purple";
    };

    python = {
      style = "yellow";
    };

    # For non-Fish shells, show a shell indicator. Without this, it is not
    # clear which shell is being used, since Starship is used by all shells.
    shell = {
      disabled = false;
      fish_indicator = "";
      # Default format string, but without an added space on the end. This
      # places the prompt closer to the shell indicator, but only if one is
      # shown. Otherwise most day-to-day usage with Fish shows no shell
      # indicator, but instead a single space before the prompt.
      format = "[$indicator]($style)";
    };
  };
}
