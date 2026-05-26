{ config, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.zed-editor;
    extraPackages = [
      # Nix
      pkgs.nixd
    ];
    extensions = [
      "nix"
      "perl"
    ];
    userSettings = {
      # Automatically save when changing focus.
      autosave = "on_focus_change";

      # Relative line numbers, just like Neovim.
      relative_line_numbers = "enabled";
    };
  };
}
