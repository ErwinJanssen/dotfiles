{ config, pkgs, ... }:

let
  theme = {
    theme = builtins.fromJSON (builtins.readFile ../../theme.json);
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "erwin";
  home.homeDirectory = "/home/erwin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The default locale to use.
  home.language.base = "en_US.UTF-8";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Packages that need to be installed, but are not included through other
    # modules.
    pkgs.fd
    pkgs.fira-code

    # fzf.vim automatically uses `bat` for file previews if it is available.
    pkgs.bat

    # Useful utilities for working with Nix
    pkgs.nix-index

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Extra directories to add to `$PATH`.
  # These values are appended to `$PATH`, it is not possible to insert paths
  # with a higher priority than the default paths already defined.
  home.sessionPath = [
    # Add Flatpak bin directory to PATH
    "/var/lib/flatpak/exports/bin"
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/erwin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    BROWSER = "firefox";
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };
  # Font setup: Fira Code as default monospace font. The prefix '20' ensures it
  # is loaded after the Home Manager generated `10-hm-fonts.conf`.
  home.file.".config/fontconfig/conf.d/20-default-monospace.conf".text = ''
    <alias>
      <family>monospace</family>
      <prefer><family>Fira Code</family></prefer>
    </alias>
  '';

  # Configure user-global EditorConfig settings.
  editorconfig = import ./editorconfig.nix;

  # Set program configurations by importing `programs.nix`.
  programs = import ./programs.nix {
    config = config;
    theme = theme;
    pkgs = pkgs;
  };

  # Configure services by importing `services.nix`.
  services = import ./services.nix { theme = theme; };

  # Configure Wayland display managers by importing `wayland.nix`.
  wayland = import ./wayland.nix;
}
