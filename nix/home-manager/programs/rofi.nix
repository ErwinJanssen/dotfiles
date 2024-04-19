{ config, theme }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  enable = true;
  extraConfig = {
    ssh-command = "{terminal} -e \"{ssh-client} {host}\"";
    sorting-method = "fzf";
    matching = "fuzzy";
  };

  # Read extra configuration from template `theme.rasi`.
  theme = {
    "*" = {
      # Make everything transparent so the right background colors show up,
      # instead of providing a background-color to all elements.
      background-color = mkLiteral "rgba ( 0, 0, 0, 0 % )";

      # Set the default text color for all elements. This is also the color of
      # the text if rofi is called with invalid arguments.
      text-color = mkLiteral theme.ui.search.default.foreground;

      # The default highlight style for matches is to color the match without
      # any additional text styling.
      highlight = mkLiteral "none ${theme.ui.search.item.match}";
    };

    # Create a full screen window with 80% transparency, with the content
    # centered in the middle. The padding sets the size of the content, because
    # Rofi does not support setting the `width` or `height` on the #mainbox
    # element. This might not yield the correct result for all display sizes.
    "#window" = {
      background-color = mkLiteral "${theme.ui.search.default.background}cc";
      transparency = "real";
      fullscreen = true;
      padding = mkLiteral "20% 30%";
    };

    "#element" = {
      background-color = mkLiteral theme.ui.search.item.background;
      padding = mkLiteral "0.4em 1em";
      margin = mkLiteral "0.5em 0 0 0";

      # The selected element is given a colored border as indicator. To prevent
      # the text in the selected element from jumping to the right because of
      # the added border, all elements are given an invisible border.
      border = mkLiteral "0 0 0 0.2em";
    };

    "#element.selected" = {
      background-color = mkLiteral theme.ui.search.selected.background;
      text-color = mkLiteral theme.ui.search.selected.foreground;
      border-color = mkLiteral theme.ui.search.selected.foreground;
      highlight = mkLiteral "bold ${theme.ui.search.selected.match}";
    };

    "#inputbar" = {
      background-color = mkLiteral theme.ui.search.input.background;
      text-color = mkLiteral theme.ui.search.input.foreground;
      border = mkLiteral "0.1em";
      border-color = mkLiteral theme.ui.search.input.background;
      margin = mkLiteral "0 0 0.5em 0";
    };

    "#prompt" = {
      padding = mkLiteral "0.5em 1em";
    };

    "#entry" = {
      background-color = mkLiteral "${theme.ui.search.default.background}cc";
      padding = mkLiteral "0.5em 1em";
    };

    "#case-indicator" = {
      padding = mkLiteral "0.5em 0";
    };
  };
}
