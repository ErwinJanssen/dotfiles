{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Erwin Janssen";
        email = "code@erwinjanssen.nl";
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        # Explicitly use the SSH config found in the home directory.
        # This prevents SSH from using the system wide configuration,
        # which makes it more reproducible across devices.
        sshCommand = "ssh -F ~/.ssh/config";
      };
      commit = {
        gpgSign = true;
      };
      signing = {
        key = "8C066B7189E4DF0E";
        signByDefault = true;
      };
    };
    includes = [
      {
        # Automatically use correct email address for work repos.
        condition = "gitdir:~/workspace/team.blue/";
        contents = {
          user = {
            email = "erwin.janssen@team.blue";
          };
        };
      }

    ];
  };
}
