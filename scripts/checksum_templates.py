import argparse
import hashlib
import pathlib

parser = argparse.ArgumentParser()
parser.add_argument("--verbose", action="store_true")

if __name__ == "__main__":
    args = parser.parse_args()

    # Compute checksum of all template files
    template_paths = sorted(pathlib.Path("guix/services").glob("*/templates/*"))
    checksum = hashlib.sha256()
    for path in template_paths:
        if args.verbose:
            print(str(path))

        # Update checksum with both the file path and its contents. If the path
        # is omitted, renamed files will not be detected as changed.
        checksum.update(bytes(path))
        checksum.update(path.read_bytes())
    checksum = checksum.hexdigest()

    # Compare checksum with previous value and update if not equal.
    # Do nothing if the checksums match, this keeps the 'update at' time of the
    # file as it was. The Makefile recipe rely on this.
    try:
        with open("templates.checksum") as file:
            previous_checksum = file.read().strip()
    except FileNotFoundError:
        previous_checksum = ""

    if checksum != previous_checksum:
        with open("templates.checksum", "w") as file:
            print(checksum, file=file)
