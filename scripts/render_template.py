import argparse
import json

import jinja2

parser = argparse.ArgumentParser()
parser.add_argument("template_file")
parser.add_argument("data_files", nargs="*")

if __name__ == "__main__":
    args = parser.parse_args()

    data = {}
    for data_file in args.data_files:
        with open(data_file) as file:
            data |= json.load(file)

    with open(args.template_file) as file:
        template = jinja2.Environment().from_string(file.read())

    print(template.render(data))
