{ config, options, pkgs, pkgs', lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = with types; {
    enable = mkBoolOpt false;

    aliases = mkOpt (attrsOf (either str path)) {};

    rcInit = mkOpt' lines "" ''
      Zsh lines to be written to $XDG_CONFIG_HOME/zsh/extra.zshrc and sourced by
      $XDG_CONFIG_HOME/zsh/.zshrc
    '';
    envInit = mkOpt' lines "" ''
      Zsh lines to be written to $XDG_CONFIG_HOME/zsh/extra.zshenv and sourced
      by $XDG_CONFIG_HOME/zsh/.zshenv
    '';

    rcFiles  = mkOpt (listOf (either str path)) [];
    envFiles = mkOpt (listOf (either str path)) [];
  };

  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.zsh;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      # I init completion myself, because enableGlobalCompInit initializes it
      # too soon, which means commands initialized later in my config won't get
      # completion, and running compinit twice is slow.
      enableGlobalCompInit = false;
      promptInit = "";
    };

    user.shell = pkgs.zsh;

    user.packages = with pkgs; [
      zsh
      nix-zsh-completions
      bat
      mdcat # cat for markdown
      pandoc
      exa
      fasd
      fd
      fzf
      tldr
      jq
      xdotool
      notify-desktop
      tree
      killall
      at
      dmenu
      entr
      ledger
      appimage-run
    ] ++ (with pkgs'; [sageWithDoc]);

    env = {
      ZDOTDIR     = "$XDG_CONFIG_HOME/zsh";
      ZSH_CACHE   = "$XDG_CACHE_HOME/zsh";
      ZGEN_DIR    = "$XDG_DATA_HOME/zsh";
      ZGEN_SOURCE = "$ZGEN_DIR/zgen.zsh";
    };

    home.configFile = {
      # Write it recursively so other modules can write files to it
      "zsh" = { source = "${configDir}/zsh"; recursive = true; };

      "zsh/extra.zshrc".text =
        let aliasLines = mapAttrsToList (n: v: "alias ${n}=\"${v}\"") cfg.aliases;
        in ''
           # This file was autogenerated, do not edit it!
           ${concatStringsSep "\n" aliasLines}
           ${concatMapStrings (path: "source '${path}'\n") cfg.rcFiles}
           ${cfg.rcInit}
        '';

      "zsh/extra.zshenv".text = ''
        # This file is autogenerated, do not edit it!
        ${concatMapStrings (path: "source '${path}'\n") cfg.envFiles}
        ${cfg.envInit}
      '';
    };

    system.userActivationScripts.cleanupZgen = "rm -fv $XDG_CACHE_HOME/zsh/*";
  };
}
