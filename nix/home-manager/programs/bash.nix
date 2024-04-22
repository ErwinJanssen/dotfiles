{
  enable = true;
  historyControl = [
    # Commands starting with a space are not saved.
    "ignorespace"

    # Executing the same command multiple times only stores it once.
    "ignoredups"

    # Previous history entries matching the command will be removed before the
    # command is saved (prevents duplicates when searching through the
    # history).
    "erasedups"
  ];
}
