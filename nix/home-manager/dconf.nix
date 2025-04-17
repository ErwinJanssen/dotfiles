{
  settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "enable-animations" = false;
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

    "org/gnome/desktop/wm/keybindings" = {
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
      command = "wezterm";
      name = "Terminal";

    };

    "org/gnome/shell/extensions/quake-terminal" = {
      horizontal-size = 80;
      render-on-current-monitor = true;
      terminal-id = "org.wezfurlong.wezterm.desktop";
      terminal-shortcut = [ "<Super>minus" ];
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

  };
}
