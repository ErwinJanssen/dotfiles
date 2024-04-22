{
  enable = true;
  settings = {
    "*" = {
      charset = "utf-8";

      # Trim trailing whitespace on every line. Does not touch trailing empty
      # newlines at the end of the file.
      trim_trailing_whitespace = true;

      # Ensure at least one final newline is always present.
      insert_final_newline = true;
    };
  };
}
