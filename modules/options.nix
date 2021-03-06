{ config, options, lib, ... }:

with lib;
{
  options = with types; {
    user = mkOption {type=attrs;};

    home = {
      file  = mkOption 
      { 
        type=attrs;
        description="Files to place directly in $HOME";
      };
      configFile = mkOption 
      { 
        type=attrs;
        description="Files to place in $XDG_CONFIG_HOME";
      };
      dataFile   = mkOption 
      {
        type=attrs;
        description="Files to place in $XDG_DATA_HOME";
      };
    };

    env = mkOption {
      type = attrsOf (oneOf [ str path (listOf (either str path)) ]);
      apply = mapAttrs
        (n: v: if isList v
               then concatMapStringsSep ":" (x: toString x) v
               else (toString v));
      default = {};
    };
  };

  config = {
      user = 
        let user = builtins.getEnv "USER";
            name = if elem user [ "" "root" ] then "tim" else user;
        in {
          inherit name;
          description = "The primary user account";
          extraGroups = [ "wheel" ];
          isNormalUser = true;
          home = "/home/${name}";
          uid = 1000;
        };
    # Install user packages to /etc/profiles instead. Necessary for
    # nixos-rebuild build-vm to work.
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      # I only need a subset of home-manager's capabilities. That is, access to
      # its home.file, home.xdg.configFile and home.xdg.dataFile so I can deploy
      # files easily to my $HOME, but 'home-manager.users.hlissner.home.file.*'
      # is much too long and harder to maintain, so I've made aliases in:
      #
      #   home.file        ->  home-manager.users.hlissner.home.file
      #   home.configFile  ->  home-manager.users.hlissner.home.xdg.configFile
      #   home.dataFile    ->  home-manager.users.hlissner.home.xdg.dataFile
      users.${config.user.name} = {
        home = {
          file = mkAliasDefinitions options.home.file;
          # Necessary for home-manager to work with flakes, otherwise it will
          # look for a nixpkgs channel.
          stateVersion = config.system.stateVersion;
        };
        xdg = {
          configFile = mkAliasDefinitions options.home.configFile;
          dataFile   = mkAliasDefinitions options.home.dataFile;
        };
      };
    };

    env.PATH = let binDir = "$XDG_CONFIG_HOME/dotfiles/bin"; in
               ["${binDir}" "${binDir}/rofi" "$XDG_BIN_HOME" "$PATH" ];

    users.users.${config.user.name} = mkAliasDefinitions options.user;

    nix = let users = [ "root" config.user.name ]; in {
      trustedUsers = users;
      allowedUsers = users;
    };

    environment.extraInit =
      concatStringsSep "\n"
        (mapAttrsToList (n: v: "export ${n}=\"${v}\"") config.env);
  };
}
