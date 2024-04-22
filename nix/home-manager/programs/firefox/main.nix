{ theme }:
{
  # Configure Firefox using Nix Home Manger, but use the system Firefox.
  enable = true;
  package = null;
  profiles = {
    default = {
      path = "default.profile";
      isDefault = true;
      userChrome = import ./userChrome.css { theme = theme; };
    };
  };
}
