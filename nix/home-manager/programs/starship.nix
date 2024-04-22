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
  };
}
