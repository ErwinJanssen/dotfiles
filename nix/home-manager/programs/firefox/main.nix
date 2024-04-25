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
      settings = {
        # Allow custom `userChrome.css`.
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Hide the bookmarks toolbar as this takes up vertical space. Use the
        # bookmarks side-panel instead when needed.
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };
}
