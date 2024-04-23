{
  enable = true;
  shellInit = builtins.readFile ./shell_init.fish;
  interactiveShellInit = builtins.readFile ./interactive_shell_init.fish;
  shellAliases = {
    ls = "eza";
  };
}
