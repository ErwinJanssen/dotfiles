import pathlib
import textwrap


def get_service_paths() -> list[pathlib.Path]:
    services_root_path = pathlib.Path("guix/services")
    return [path for path in services_root_path.iterdir() if path.is_dir()]


def get_template_paths(service_path: pathlib.Path) -> list[pathlib.Path]:
    try:
        return list((service_path / "templates").glob("**/*"))
    except FileNotFoundError:
        # No 'templates' directory exists
        return []


def generate_template_recipes(service_path, template_path):
    base_template_path = template_path.relative_to(service_path / "templates")

    output_path = service_path / "generated" / base_template_path
    output_path.parent

    recipes = set()
    recipes.add(f"process-templates: {output_path}")

    recipes.add(
        textwrap.dedent(
            f"""\
        {output_path.parent}:
        \tmkdir --parent '{output_path.parent}'
        """
        )
    )

    recipes.add(
        textwrap.dedent(
            f"""\
            {output_path}: {template_path} theme.json {output_path.parent}
            \tpython3 scripts/render_template.py '{template_path}' theme.json > '{output_path}'
            """
        )
    )

    return recipes


if __name__ == "__main__":
    recipes = set()
    for service_path in get_service_paths():
        for path in get_template_paths(service_path):
            if path.is_file():
                recipes |= generate_template_recipes(service_path, path)

    print("\n".join(sorted(recipes)))
