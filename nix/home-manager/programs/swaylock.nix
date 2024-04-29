{ pkgs, theme }:
let
  # The hex value 'bf' means 25% transparency.
  alpha = "bf";
in
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

    # Colors when typing in the password.
    inside-color = "${theme.colors.normal.magenta}${alpha}";
    ring-color = theme.colors.normal.magenta;
    line-color = theme.colors.normal.black;
    text-color = theme.colors.normal.black;
    key-hl-color = theme.colors.bright.magenta;
    bs-hl-color = theme.colors.bright.yellow;

    # Colors when the password input is cleared, by backspaces or Escape.
    inside-clear-color = "${theme.colors.normal.yellow}${alpha}";
    ring-clear-color = theme.colors.normal.yellow;
    line-clear-color = theme.colors.normal.black;
    text-clear-color = theme.colors.normal.black;

    # Colors when the password is being verified.
    inside-ver-color = "${theme.colors.normal.green}${alpha}";
    ring-ver-color = theme.colors.normal.green;
    line-ver-color = theme.colors.normal.black;
    text-ver-color = theme.colors.normal.black;

    # Colors when the password is wrong.
    inside-wrong-color = "${theme.colors.normal.red}${alpha}";
    ring-wrong-color = theme.colors.normal.red;
    line-wrong-color = theme.colors.normal.black;
    text-wrong-color = theme.colors.normal.black;
  };
}
