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
      modules-left = [ "sway/workspaces" ];
      modules-right = [
        "network"
        "battery"
        "cpu"
        "memory"
        "clock"
      ];

      # Battery capacity and charge status.
      battery = {
        # Charge level can be polled less frequently.
        interval = 30;

        states = {
          warning = 30;
          critical = 15;
        };

        format = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";

        # Use fancy icons for battery levels.
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];

        # In the tooltip, show the time remaining, current power draw and
        # total number of charge cycles seen.
        tooltip-format = "{timeTo}\nPower draw: {power:.2f} W";
      };

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

      # Network connectivity.
      network = {
        # Information and icons depend on connection type.
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";

        # Shw IP address and gateway in tooltip.
        tooltip-format = "{ifname}:\n  {ipaddr}/{cidr}\n  via {gwaddr}";
      };
    };
  };
}
