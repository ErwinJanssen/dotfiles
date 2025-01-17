{
  config,
  pkgs,
}:
{
  enable = true;
  package = config.lib.nixGL.wrap pkgs.thunderbird;
  profiles = {
    default = {
      isDefault = true;
      settings = {
        # Sort by date.
        "mailnews.default_sort_type" = 18;

        # Descending sort by default, show most recent first.
        "mailnews.default_sort_order" = 2;

        # Disable threads.
        "mailnews.default_view_flags" = 0;
      };
    };
  };
}
