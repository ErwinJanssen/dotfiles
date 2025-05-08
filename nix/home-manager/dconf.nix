{
  theme,
}:
{
  settings = {
    "com/github/amezin/ddterm" = {
      "ddterm-toggle-hotkey" = [ "<Super>minus" ];

      # Disable 'bell' sounds.
      audible-bell = false;

      # Do not restore tabs on startup.
      save-restore-session = false;

      # Set cursor shape to 'beam' instead of 'block'.
      cursor-shape = "ibeam";

      # Use custom theme colors
      use-theme-colors = false;
      background-color = theme.theme.normal.background;
      foreground-color = theme.theme.normal.foreground;
      palette = [
        theme.colors.normal.black
        theme.colors.normal.red
        theme.colors.normal.green
        theme.colors.normal.yellow
        theme.colors.normal.blue
        theme.colors.normal.magenta
        theme.colors.normal.cyan
        theme.colors.normal.white
        theme.colors.bright.black
        theme.colors.bright.red
        theme.colors.bright.green
        theme.colors.bright.yellow
        theme.colors.bright.blue
        theme.colors.bright.magenta
        theme.colors.bright.cyan
        theme.colors.bright.white
      ];
    };

    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "enable-animations" = false;
      monospace-font-name = "Fira Code 11";
    };
    "org/gnome/desktop/input-sources" = {
      # Map `<CapsLock>` to `<Escape>` by default, enable actual `<CapsLock>`
      # with `<Shift>+<CapsLock>`.
      xkb-options = [ "caps:escape_shifted_capslock" ];
    };

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

    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Define multiple keybindings for closing a window.
      close = [
        # Alt+F4: Default value in GNOME and many other window
        # managers, as well as Microsoft Windows.
        "<Alt>F4"

        # Default on Sway/i3, and convenient on laptops where the fn
        # key is needed to access F4.
        "<Shift><Super>q"
      ];

      # Move applications to a different workspace.
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      move-to-workspace-9 = [ "<Super><Shift>9" ];
      move-to-workspace-10 = [ "<Super><Shift>0" ];

      # Go to diffent workspace.
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      switch-to-workspace-10 = [ "<Super>0" ];

      # Switch between applications, which groups windows of the same
      # application type.
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];

      # Switch between all open windows, does not group based on
      # application.
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];

      # Keybinding to make window fullscreen, similar to Sway.
      toggle-fullscreen = [ "<Super>f" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      # Have a static number of 10 workspaces. Otherwise the 'switch to
      # workspace' bindings do not work as expected.
      num-workspaces = 10;
    };

    "org/gnome/mutter" = {
      # Use a fixed number of workspaces and do not remove empty ones. Number
      # of workspaces is defined in `org/gnome/desktop/wm/preferences`
      dynamic-workspaces = false;
    };

    # Custom keybindings have to be registered, as well as defined separately.
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
      ];
    };

    # Similar to Sway, open a terminal on <Super>+<Enter>.
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "Terminal";

    };

    "org/gnome/shell/app-switcher" = {
      # No not limit application switch to current workspace.
      current-workspace-only = false;
    };

    "org/gnome/shell/keybindings" = {
      # By default, these are defined as <Super>+<number>. If left at their
      # default values, they take precedence over the bindings to switch
      # workspaces.
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
    };

    "org/gnome/shell/window-switcher" = {
      # No not limit window switch to current workspace.
      current-workspace-only = false;
    };

  };
}
