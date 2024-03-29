{config, lib, pkgs,  ...}:
with lib;
with lib.my;
let myXmind = pkgs.xmind.override { gtk2 = pkgs.gtk3-x11; }; in
{
  services.xserver.enable = true;
  services.xserver.layout = "us";

  xdg.mime.enable = true;

  user.packages = with pkgs; [
    feh       # image viewer
    imagemagick # for feh
    maim # screenshots
    sxhkd # keybindings, wm independent
    xclip
    xdotool
    xorg.xwininfo
    zotero
    # thunderbird
    # drawio # diagrams
    # vym # mindmap
    gnome3.zenity
    # zulip # work
    wmname
    vlc
    # zeal
    appimage-run
    # tdesktop # telegram
    # geogebra6
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

  services.picom = {
    backend = "glx";
    vSync = true;
    opacityRules = [
      "100:class_g = 'VirtualBox Machine'"
      "100:class_g = 'Gimp'"
      "100:class_g = 'Inkscape'"
      "100:class_g = 'aseprite'"
      "100:class_g = 'krita'"
      "100:class_g = 'feh'"
      "100:class_g = 'mpv'"
      "100:class_g = 'Rofi'"
      "100:class_g = 'Peek'"
      "99:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"
    ];
    shadowExclude = [
      # Put shadows on notifications, the scratch popup and rofi only
      "! name~='(rofi|scratch|Dunst)$'"
    ];
    settings = {
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Rofi'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      # Unredirect all windows if a full-screen opaque window is detected, to
      # maximize performance for full-screen windows. Known to cause
      # flickering when redirecting/unredirecting windows.
      unredir-if-possible = true;

      # GLX backend: Avoid using stencil buffer, useful if you don't have a
      # stencil buffer. Might cause incorrect opacity when rendering
      # transparent content (but never practically happened) and may not work
      # with blur-background. My tests show a 15% performance boost.
      # Recommended.
      glx-no-stencil = true;

      # Use X Sync fence to sync clients' draw calls, to make sure all draw
      # calls are finished before picom starts drawing. Needed on
      # nvidia-drivers with GLX backend for some users.
      xrender-sync-fence = true;
    };
  };

  env.GTK_DATA_PREFIX = [ "${config.system.path}" ];
  env.QT_QPA_PLATFORMTHEME = "gtk2";
  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };

  services.xserver.displayManager.sessionCommands = ''
    # GTK2_RC_FILES must be available to the display manager.
    export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
  '';

  services.xserver.displayManager.lightdm.greeters.mini.user = config.user.name;

  # Clean up leftovers, as much as we can
  system.userActivationScripts.cleanupHome = ''
    pushd "${config.user.home}"
    rm -rf .compose-cache .nv .pki .dbus .fehbg
    [ -s .xsession-errors ] || rm -f .xsession-errors*
    popd
  '';
}
