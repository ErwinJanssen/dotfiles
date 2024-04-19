{
  enable = true;
  interactiveShellInit = ''
    # Start Sway on tty1
    if [ (tty) = /dev/tty1 ]
        # Send Sway's output to journald, retrieve with:
        # `journalctl --user --identifier sway`
        exec systemd-cat --identifier=sway sway
    end
  '';
}
