{
    modules = {
        editors = {
            emacs.enable = true;
            emacs.doom.enable = true;
        };
        shell = {
            zsh.enable = true;
            bitwarden.enable = true;
            direnv.enable = true;
            tmux.enable = true;
        };
        dev = {
            haskell.enable = true;
        };
        theme = {
            active = "alucard";
        };
        desktop = {
            apps = {
                discord.enable = true;
                kitty.enable = true;
            };
            browsers = {
                qutebrowser.enable = true;
            };
            #bspwm = true;
            #kde = false;
        };
    };
}