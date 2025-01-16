{
  config,
  pkgs,
  theme,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.firefox;
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

      search = {
        # Set the default search engine to DuckDuckGo.
        default = "DuckDuckGo";

        # Without `force=true`, Firefox will overwrite the config on launch.
        force = true;
      };
    };
  };
}
