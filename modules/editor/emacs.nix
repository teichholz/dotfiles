{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.emacs;
in {

  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
    doom = {
      enable  = mkBoolOpt true;
      fromSSH = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # emacsPgtkGcc   # 28 + pgtk + native-comp
      emacs


      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      zstd                # for undo-fu-session/undo-tree compression
      graphviz            # org-roam

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        de 
      ]))
      # :checkers grammar
      languagetool
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang rust
      rustfmt
      rust-analyzer
    ];

    services.emacs.enable = true;
    services.emacs.package = pkgs.emacsPgtkGcc;

    env.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];
    env.EDITOR = "emacsclient";

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];
  };
}
