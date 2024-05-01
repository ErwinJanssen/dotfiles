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
      modules-right = [
        "cpu"
        "memory"
        "clock"
      ];
      clock = {
        # Show the time in 24h format.
        format = "{:%T}";

        # Refresh every second.
        interval = 1;

        # On hover, show the date and a small calendar of the current month.
        tooltip-format = "<big>{:%Y-%m-%d}</big>\n<tt><small>{calendar}</small></tt>";
      };

      # Current CPU usage.
      cpu = {
        # By default, show CPU usage as a percentage. Use the default 'tooltip'
        # which shows the per-core CPU usage.
        format = "{usage}% ";

        # Refresh every 5 seconds.
        interval = 5;

        # Set thresholds for warning/error colors.
        states = {
          warning = 80;
          critical = 90;
        };
      };

      # Current memory usage.
      memory = {
        # By default, show memory usage as a percentage.
        format = "{percentage}% ";

        # Show actual usage values on hover.
        tooltip-format = "Usage: {used:0.1f} / {total:0.1f} GiB";

        # Refresh every 5 seconds.
        interval = 5;

        # Set thresholds for warning/error colors.
        states = {
          warning = 80;
          critical = 90;
        };
      };
    };
  };
}
