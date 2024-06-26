{
  enable = true;
  arguments = [
    # Search hidden files / directories by default, but exclude .git directory
    "--hidden"
    "--glob=!.git/*"

    # Search case insensitively if the pattern is all lowercase. Search case
    # sensitively otherwise.
    "--smart-case"
  ];
}
