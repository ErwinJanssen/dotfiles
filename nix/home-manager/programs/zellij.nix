{
  enable = true;

  # 'shell integration' for Zellij means that it will start a new session
  # **every time** the shell is entered. This is not desirable.
  enableBashIntegration = false;
  enableFishIntegration = false;
  enableZshIntegration = false;

  settings = {
    # Default to starting `fish` if no shell is specified. This is mainly to
    # prevent the need to manually run `fish` each time when Zellij is started
    # using `nix develop`.
    default_shell = "fish";

    copy_command = "wl-copy";
  };
}
