{
  enable = true;
  systemdTarget = "sway-session.target";
  settings = [
    # Disable build-in display when one of these external monitors is
    # connected:

    # Desk at home
    {
      profile = {
        name = "docked_home";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "GIGA-BYTE TECHNOLOGY CO., LTD. G27Q 20362B001216";
            status = "enable";
          }
        ];
      };
    }
    # Desk at office.
    {
      profile = {
        name = "docked_office";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL S3422DW 4981TH3";
            status = "enable";
            mode = "3440x1440";
          }
        ];
      };
    }
    # Flex desk at office.
    {
      profile = {
        name = "docked_office_flex_1";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL S3422DW 4CT0TH3";
            status = "enable";
            mode = "3440x1440";
          }
        ];
      };
    }
    # Flex desk at office.
    {
      profile = {
        name = "docked_office_flex_2";
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL S3422DW BMN0TH3";
            status = "enable";
            mode = "3440x1440";
          }
        ];
      };
    }

    # If no outputs are connected, enable build-in display.
    {
      profile = {
        name = "undocked_framework";
        outputs = [
          {
            # The Framework 13 has a high resolution screen, use a larger scale
            # factor.
            criteria = "BOE 0x0BCA Unknown";
            status = "enable";
            scale = 1.3;
          }
        ];
      };
    }
    {
      profile = {
        name = "undocked_other";
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };
    }
  ];
}
