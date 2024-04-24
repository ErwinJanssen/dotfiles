{
  enable = true;
  shellInit = builtins.readFile ./shell_init.fish;
  interactiveShellInit = builtins.readFile ./interactive_shell_init.fish;
  functions = {
    print_fish_colors = {
      description = "Shows the various fish colors being used";
      body = builtins.readFile ./functions/print_fish_colors.fish;
    };
  };
  shellAliases = {
    ls = "eza";
  };
}
