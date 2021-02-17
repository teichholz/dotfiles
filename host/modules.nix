{
    modules = {
        editors = {
            emacs.enable = true;
            emacs.doom.enable = true;
        };
        shell = {
            bitwarden.enable = true;
            direnv.enable = true;
            tmux.enable = true;
            zsh.enable = true;
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
                anki.enable = true;
            };
            browsers = {
                qutebrowser.enable = true;
            };
            bspwm.enable = true;
            kde.enable = false;
        };
    };
}