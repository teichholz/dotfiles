{config, lib, pkgs,  ...}:
with lib;
with lib.my;
{
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.screenSection = ''
    Option "NoFlip" "true"
  '';

  hardware.nvidia = {
    modesetting.enable = true;
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    setLdLibraryPath = true;
  };
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  user.packages = with pkgs; [
    feh       # image viewer
    maim # screenshots
    sxhkd # keybindings, wm independent
    xclip
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      ubuntu_font_family
      dejavu_fonts
      iosevka
      symbola
      noto-fonts
      noto-fonts-cjk
    ];
  };

  services.xserver.displayManager.lightdm.greeters.mini.user = config.user.name;
}