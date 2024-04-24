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

    # Comment stuff out
    vim-commentary

    # Fuzzy finder
    fzfWrapper
    fzf-vim

    # Display pop-up with possible key bindings
    which-key-nvim

    # Visualize undo tree
    vim-mundo

    # Show Git diff in the signcolumn (added, removed, modified).
    gitsigns-nvim

    # Lightweight status line
    lightline-vim
  ];
}
