{
  settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      # This seems to enable both 'areas' and 'tap to click'.
      click-method = "areas";

      # Prevent accidental mouse movements during typing.
      disable-while-typing = true;

      # Scroll the viewport, not the content.
      natural-scroll = false;

      # Scroll using two fingers, the alternative is dragging a single
      # finger at the edge of the touchpad.
      two-finger-scrolling-enabled = true;
    };
  };
}
