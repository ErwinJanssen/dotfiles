"""Generate theme colors to be used when deploying the configuration."""

import json

from colormath.color_conversions import convert_color
from colormath.color_objects import LCHabColor, sRGBColor


def lch_to_hex(lightness: float, chroma: float, hue: float) -> str:
    """Convert LCH colors values to RGB hex."""
    lch = LCHabColor(lightness, chroma, hue)
    rgb = convert_color(lch, sRGBColor)
    clamped_rgb = sRGBColor(rgb.clamped_rgb_r, rgb.clamped_rgb_g, rgb.clamped_rgb_b)
    return clamped_rgb.get_rgb_hex()


# Set the hue for the primary accent color.
hues = {
    "red": 40,
    "green": 140,
    "yellow": 90,
    "blue": 260,
    "magenta": 300,
    "cyan": 197,
}

# Default lightness and chroma for different color shades.
normal_lightness = 60
normal_chroma = 40

# The bright colors must be more vibrant, so the chroma must be increased.
# The lightness is lowered. An increased lightness results colors that are more
# pale, and colors with higher lightness are more often out of the sRGB color
# range.
bright_lightness = normal_lightness - 20
bright_chroma = normal_chroma + 40

# Set the primary/accent color
primary_color = "magenta"

# Mix a slight amount of the primary hue in blacks. Chroma goes from 0-150, so
# 0.75 means 0.5%.
black_chroma = 0.75

# Define the different shades of each color
colors = {
    "normal": {
        "black": lch_to_hex(20, black_chroma, hues[primary_color]),
        "red": lch_to_hex(normal_lightness, normal_chroma, hues["red"]),
        "green": lch_to_hex(normal_lightness, normal_chroma, hues["green"]),
        "yellow": lch_to_hex(normal_lightness + 20, normal_chroma, hues["yellow"]),
        "blue": lch_to_hex(normal_lightness, normal_chroma, hues["blue"]),
        "magenta": lch_to_hex(normal_lightness, normal_chroma, hues["magenta"]),
        "cyan": lch_to_hex(normal_lightness, normal_chroma, hues["cyan"]),
        "white": lch_to_hex(80, 5, hues[primary_color]),
    },
    "bright": {
        "black": lch_to_hex(35, black_chroma, hues[primary_color]),
        "red": lch_to_hex(bright_lightness, bright_chroma, hues["red"]),
        "green": lch_to_hex(bright_lightness, bright_lightness, hues["green"]),
        "yellow": lch_to_hex(bright_lightness + 40, bright_chroma, hues["yellow"]),
        "blue": lch_to_hex(bright_lightness, bright_chroma, hues["blue"]),
        "magenta": lch_to_hex(bright_lightness, bright_chroma, hues["magenta"]),
        "cyan": lch_to_hex(bright_lightness, bright_chroma, hues["cyan"]),
        "white": lch_to_hex(90, 5, hues[primary_color]),
    },
    "dim": {
        "black": lch_to_hex(15, black_chroma, hues[primary_color]),
        "red": lch_to_hex(25, 40, hues["red"]),
        "green": lch_to_hex(25, 25, hues["green"]),
        "blue": lch_to_hex(25, 25, hues["blue"]),
        "magenta": lch_to_hex(20, 20, hues["magenta"]),
    },
    "dimmer": {"black": lch_to_hex(10, black_chroma, hues[primary_color])},
}

# Add 'greys' to the color definitions. For each hue, the grey version has
# both lower lightness and chroma.
colors["grey"] = {}
for hue_name, hue_value in hues.items():
    colors["grey"][hue_name] = lch_to_hex(
        normal_lightness - 10, normal_chroma / 2, hue_value
    )


# Provide some high level color definitions such as which color is the accent
# color.
theme = {
    "normal": {
        "background": colors["dim"]["black"],
        "foreground": colors["normal"]["white"],
        "accent": colors["normal"]["magenta"],
        "match": colors["normal"]["green"],
        "urgent": colors["dim"]["red"],
        "success": colors["normal"]["green"],
        "warning": colors["normal"]["yellow"],
        "error": colors["normal"]["red"],
    },
    "bright": {
        "background": colors["normal"]["black"],
        "foreground": colors["bright"]["white"],
        "accent": colors["bright"]["magenta"],
        "match": colors["bright"]["green"],
    },
    "brighter": {
        "background": colors["bright"]["black"],
    },
    "dim": {
        "background": colors["dimmer"]["black"],
        "accent": colors["dim"]["magenta"],
    },
}

# Given the theme colors, provide some concrete definitions for UI elements.
# These descriptive names can be used in the appropriate places.
ui = {
    "window": {
        "border": {
            "normal": theme["dim"]["accent"],
            "bright": theme["normal"]["accent"],
        },
    },
    "search": {
        "default": {
            "background": theme["normal"]["background"],
            "foreground": theme["normal"]["foreground"],
        },
        "input": {
            "background": theme["dim"]["accent"],
            "foreground": theme["normal"]["foreground"],
        },
        "selected": {
            "background": theme["brighter"]["background"],
            "foreground": theme["normal"]["accent"],
            "match": theme["bright"]["match"],
        },
        "item": {
            "background": theme["bright"]["background"],
            "match": theme["normal"]["match"],
        },
    },
    "status_bar": {
        "default": {
            "background": theme["bright"]["background"],
            "foreground": theme["normal"]["foreground"],
        },
        "tab": {
            "background": theme["bright"]["background"],
            "foreground": theme["normal"]["foreground"],
        },
        "active": {
            "background": theme["normal"]["accent"],
            "foreground": theme["dim"]["accent"],
        },
        "urgent": {
            "background": theme["normal"]["urgent"],
            "foreground": theme["normal"]["foreground"],
        },
    },
}

# Print a JSON object with all colors definitions combined.
if __name__ == "__main__":
    data = {
        "colors": colors,
        "theme": theme,
        "ui": ui,
    }
    print(json.dumps(data, indent=4))
