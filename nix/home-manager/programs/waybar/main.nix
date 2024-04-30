{ theme }:
{
  enable = true;
  systemd = {
    enable = true;
  };
  style = import ./style.css theme;
  settings = {
    mainBar = {
      position = "top";
      modules-right = [ "clock" ];
      clock = {
        # Show the time in 24h format.
        format = "{:%T}";

        # Refresh every second.
        interval = 1;

        # On hover, show the date and a small calendar of the current month.
        tooltip-format = "<big>{:%Y-%m-%d}</big>\n<tt><small>{calendar}</small></tt>";
      };
    };
  };
}
