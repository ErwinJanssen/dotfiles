{ pkgs }:
{
  enable = true;

  # The `swaylock` package installed via Home Manager is not able to unlock the
  # sessions due to missing PAM integration. However, the `package` option of
  # this module cannot be `null`, so use the dummy `hello` package instead.
  package = pkgs.hello;
  settings = {
    daemonize = true;
    image = "$HOME/.config/sway/wallpaper.jpg";
    scaling = "fill";
  };
}
