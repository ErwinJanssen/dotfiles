{ theme }:
{
  enable = true;
  general = {
    colors = true;
    color_good = theme.theme.normal.success;
    color_degraded = theme.theme.normal.warning;
    color_bad = theme.theme.normal.error;
    interval = 5;
  };
  enableDefault = false;
  modules = {
    "ipv6" = {
      enable = true;
      position = 1;
    };
    "wireless _first_" = {
      enable = true;
      position = 2;
      settings = {
        format_up = "W: (%quality at %essid) %ip";
        format_down = "W: down";
      };
    };

    "ethernet _first_" = {
      enable = true;
      position = 3;
      settings = {
        format_up = "E: %ip (%speed)";
        format_down = "E: down";
      };
    };
  };
}
