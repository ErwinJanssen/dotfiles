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
    "red": 30,
    "green": 140,
    "yellow": 100,
    "blue": 260,
    "magenta": 300,
    "cyan": 197,
}

# Set the primary/accent color
primary_color = "magenta"

# Define the different shades of each color
colors = {
    "normal": {
        "black": lch_to_hex(20, 0, 0),
        "red": lch_to_hex(52.4, 43, hues["red"]),
        "green": lch_to_hex(66.6, 45, hues["green"]),
        "yellow": lch_to_hex(81.5, 35, hues["yellow"]),
        "blue": lch_to_hex(69.2, 20.5, hues["blue"]),
        "magenta": lch_to_hex(68.75, 54.5, hues["magenta"]),
        "cyan": lch_to_hex(76.85, 27.5, hues["cyan"]),
        "white": lch_to_hex(80, 5, hues[primary_color]),
    },
    "bright": {
        "black": lch_to_hex(35, 0, 0),
        "red": lch_to_hex(56.9, 76, hues["red"]),
        "green": lch_to_hex(72.6, 81.75, hues["green"]),
        "yellow": lch_to_hex(97, 81, hues["yellow"]),
        "blue": lch_to_hex(63.5, 42, hues["blue"]),
        "magenta": lch_to_hex(51.4, 87, hues["magenta"]),
        "cyan": lch_to_hex(82.6, 46.5, hues["cyan"]),
        "white": lch_to_hex(90, 5, hues[primary_color]),
    },
    "dim": {
        "black": lch_to_hex(15, 0, 0),
        "red": lch_to_hex(22.7, 41, hues["red"]),
        "green": lch_to_hex(23.5, 24, hues["green"]),
        "blue": lch_to_hex(26.75, 25.5, hues["blue"]),
        "magenta": lch_to_hex(20.5, 20.5, hues["magenta"]),
    },
    "dimmer": {"black": lch_to_hex(10, 0, 0)},
}


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
