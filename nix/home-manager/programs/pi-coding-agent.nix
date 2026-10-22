{
  home.file.".pi/agent/extensions/blueai.ts".source = ../files/pi/blueai.ts;

  programs.pi-coding-agent = {
    enable = true;
    context = ../files/AGENTS.md;
  };
}
