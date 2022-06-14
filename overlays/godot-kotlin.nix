self: super: {
  godot-mono = with super;
  let
    arch = "64";
    pkg = stdenv.mkDerivation  {
      name = "godot-mono-unwrapped";
      buildInputs = [ unzip ];
      unpackPhase = "unzip $src";
      version = version;
      src = fetchurl {
        url = "https://github.com/utopia-rise/godot-kotlin-jvm/releases/download/0.3.4-3.4.4/godot-kotlin-jvm_editor_x11_.zip";
        sha256 = "sha256-imyJ/oYjZ++EeEdN99JrUuBapMr40PSuGWcuRTEc0Qw=";
      };
      installPhase = ''
        cp -r . $out
      '';
    };
  in buildFHSUserEnv {
    name = "godot-kotlin";
    targetPkgs = pkgs: (with pkgs;
      [ alsaLib
        dotnetCorePackages.sdk_5_0
        libGL
        libpulseaudio
        libudev
        xorg.libX11
        xorg.libXcursor
        xorg.libXext
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
        zlib
      ]);
    runScript = "${pkg.outPath}/godot.x11.opt.tools.${arch}";
  };
}
