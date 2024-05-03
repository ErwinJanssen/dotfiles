{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  extraConfigVim = builtins.readFile ./init.vim;
  extraPackages = [
    # Used by Mason to build and install packages.
    pkgs.cargo
    pkgs.gcc9 # Cargo needs a C compiler for linking.
    pkgs.nodejs_21

    # Dependencies of Ansible language server.
    pkgs.ansible
    pkgs.ansible-lint
  ];
  extraPlugins = with pkgs.vimPlugins; [
    # Additional file types.
    ansible-vim # Ansible YAML
    vim-pandoc # Pandoc filetype and utilities
    vim-pandoc-syntax # Pandoc syntax highlight
    plantuml-syntax # PlantUML

    # Highlight color definitions (e.g. #1b1b1b, DarkGray, hsl(20, 30%, 50%))
    nvim-colorizer-lua

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

    # Allow for asynchronous build commands (such as :Make instead of :make),
    # for nonblocking compilation. The 'vim-dispatch-neovim' plugin will allow
    # 'vim-dispatch' to use the build-in Neovim terminal.
    vim-dispatch
    vim-dispatch-neovim

    # Treesitter: more advanced syntax highlighting
    nvim-treesitter.withAllGrammars

    # Auto-completion during typing, uses various sources
    nvim-compe

    # Configuration for Neovim's built-in language server client
    nvim-lspconfig

    # Install and manage LSP servers, linters, etc.
    mason-nvim

    # Bridge between `mason` and `lspconfig`
    mason-lspconfig-nvim
  ];
}
