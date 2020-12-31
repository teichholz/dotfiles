{config, lib, pkgs,  ...}:
{
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.screenSection = ''
    Option "NoFlip" "true"
  '';
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

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
}