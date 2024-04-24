{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  extraConfig = builtins.readFile ./init.vim;
  plugins = with pkgs.vimPlugins; [
    # Fuzzy finder
    fzfWrapper
    fzf-vim
  ];
}
