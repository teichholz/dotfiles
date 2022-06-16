self: super: {
  godot-kotlin = with super;
  let
    arch = "64";
    pkg = stdenv.mkDerivation  {
      name = "godot-kotlin-unwrapped";
      buildInputs = [ unzip ];
      unpackPhase = "unzip $src";
      src = fetchurl {
        url = "https://github.com/utopia-rise/godot-kotlin-jvm/releases/download/0.3.4-3.4.4/godot-kotlin-jvm_editor_x11_.zip";
        sha256 = "sha256-m0saSTuAFTPk0FgEWJ9Oo6A7Qc0+xQ17tslzj2PgWks=";
      };
      installPhase = ''
        cp -r . $out
        chmod a+x "$out/godot.x11.opt.tools.${arch}"
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
