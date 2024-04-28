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
    };
  };
}
