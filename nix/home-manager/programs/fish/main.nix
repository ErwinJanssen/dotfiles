{
  enable = true;
  interactiveShellInit = builtins.readFile ./interactive_shell_init.fish;
  shellAliases = {
    ls = "eza";
  };
}
