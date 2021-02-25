{ config, ... }:
let assocs = {
        "image/png" = [ "feh.desktop" ];
        "image/jpg" = [ "feh.desktop" ];
        "text/plain" = [ "emacsclient.desktop" ];
        "application/pdf" = [ "evince.desktop" ];
    }; in
{
  ### A tidy $HOME is a tidy mind
  home-manager.users.${config.user.name} = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.enable = true;
      mimeApps.defaultApplications = assocs;
      mimeApps.associations.added = assocs;
    };
  };

  environment = {
    sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_BIN_HOME    = "$HOME/.local/bin";
    };
    variables = {
      # Conform more programs to XDG conventions. The rest are handled by their
      # respective modules.
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    #   ASPELL_CONF = ''
    #     per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;
    #     personal $XDG_CONFIG_HOME/aspell/en_US.pws;
    #     repl $XDG_CONFIG_HOME/aspell/en.prepl;
    #   '';
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      HISTFILE        = "$XDG_DATA_HOME/bash/history";
      INPUTRC         = "$XDG_CONFIG_HOME/readline/inputrc";
      LESSHISTFILE    = "$XDG_CACHE_HOME/lesshst";
      WGETRC          = "$XDG_CONFIG_HOME/wgetrc";
    };
  };

}
