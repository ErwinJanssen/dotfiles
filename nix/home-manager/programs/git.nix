{
  enable = true;
  userName = "Erwin Janssen";
  userEmail = "erwinjanssen@outlook.com";
  extraConfig = {
    init = {
      defaultBranch = "main";
    };
    core = {
      # Explicitly use the SSH config found in the home directory. This
      # prevents SSH from using the system wide configuration, which makes it
      # more reproducible across devices.
      sshCommand = "ssh -F ~/.ssh/config";
    };
  };
  delta = {
    enable = true;
  };
}
