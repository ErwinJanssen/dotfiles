{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      # Do not trigger Atuin on arrow up, but keep the default CTRL-R binding.
      "--disable-up-arrow"
    ];
  };
}
