{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  extraConfig = builtins.readFile ./init.vim;
  plugins = with pkgs.vimPlugins; [
    # Additional file types.
    ansible-vim # Ansible YAML
    vim-pandoc # Pandoc filetype and utilities
    vim-pandoc-syntax # Pandoc syntax highlight
    plantuml-syntax # PlantUML

    # Fuzzy finder
    fzfWrapper
    fzf-vim
  ];
}
