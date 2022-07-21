self: super: {
  godot-mono = with super;
  let
    arch = "64";
    version = "3.3.2";
    releaseName = "stable";
    subdir = "";
    pkg = stdenv.mkDerivation  {
      name = "godot-mono-unwrapped";
      buildInputs = [ unzip ];
      unpackPhase = "unzip $src";
      version = version;
      src = fetchurl {
        url = "https://downloads.tuxfamily.org/godotengine/${version}${subdir}/mono/Godot_v${version}-${releaseName}_mono_x11_${arch}.zip";
        sha256 = "sha256-imyJ/oYjZ++EeEdN99JrUuBapMr40PSuGWcuRTEc0Qw=";
      };
      installPhase = ''
        cp -r . $out
      '';
    };
  in buildFHSUserEnv {
    name = "godot-mono";
    targetPkgs = pkgs: (with pkgs;
      [ alsaLib
        dotnetCorePackages.sdk_5_0
        libGL
        libpulseaudio
        udev
        xorg.libX11
        xorg.libXcursor
        xorg.libXext
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
        zlib
      ]);
    runScript = "${pkg.outPath}/Godot_v${version}-${releaseName}_mono_x11_${arch}/Godot_v${version}-${releaseName}_mono_x11.${arch}";
  };
}
