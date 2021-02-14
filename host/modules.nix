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
        };
        dev = {
            haskell.enable = true;
        };
        theme = {
            active = "alucard";
        };
        app = {
            browsers = {
                qutebrowser = true;
            };
            bspwm = true;
            kde = false;
        };
    };
}