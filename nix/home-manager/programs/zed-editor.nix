{ config, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.zed-editor;
    extraPackages = [
      # Nix
      pkgs.nixd
      pkgs.nixfmt
    ];
    extensions = [
      "nix"
      "perl"
      "toml"
    ];
    userSettings = {
      # Automatically save when changing focus.
      autosave = "on_focus_change";

      # Relative line numbers, just like Neovim.
      relative_line_numbers = "enabled";

      # Show a line at 80 chars to assist with formatting code, similar to
      # Neovim's 'colorcolumn'.
      show_wrap_guides = true;
      wrap_guides = [ 80 ];

      # Soft wrap on editor width to avoid horizontal scrolling.
      soft_wrap = "editor_width";
    };
  };
}
