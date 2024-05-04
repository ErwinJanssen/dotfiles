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


# Define the different shades of each color
colors = {
    "normal": {
        "black": lch_to_hex(20, 0, 0),
        "red": "#bf5f61",
        "green": "#6bb26b",
        "yellow": "#e5c689",
        "blue": "#8eadcc",
        "magenta": "#b499ff",
        "cyan": "#7acccc",
        "white": "#bfc7d5",
    },
    "bright": {
        "black": lch_to_hex(35, 0, 0),
        "red": "#f2484b",
        "green": "#3dcc3d",
        "yellow": "#ffff4c",
        "blue": "#5ba0e5",
        "magenta": "#a54cff",
        "cyan": "#2de5e5",
        "white": "#e5eeff",
    },
    "dim": {
        "black": lch_to_hex(15, 0, 0),
        "red": "#661919",
        "green": "#1f3f1f",
        "blue": "#1e4266",
        "magenta": "#362d4c",
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
