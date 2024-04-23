{ theme }:
{
  enable = true;
  settings = {
    global = {
      # Do not set a time-out by default. Otherwise notifications can disappear
      # without being seen. For pop-ups that do not require persistence, the
      # timeout can be specified when calling `notify-send`.
      timeout = 0;

      # Use the default monospace font, and set padding and gap size to be
      # equal to font size.
      font = "Monospace 12";
      padding = 12;
      gap_size = 12;

      # Limit of 6 notifications, with an 'overflow' when needed. This overflow
      # takes up a slot so when there are more than 6 notification, the first
      # 5 are shown.
      notification_limit = 6;
      indicate_hidden = 1;

      # Colors
      foreground = theme.theme.bright.foreground;
      background = theme.theme.bright.background;
      frame_color = theme.theme.normal.accent;
      frame_width = 1;
    };
  };
}
