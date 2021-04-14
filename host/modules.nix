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
            ranger.enable = true;
        };
        dev = {
            haskell.enable = true;
            scheme.enable = true;
            clojure.enable = true;
            java.enable = true;
        };
        desktop = {
            apps = {
                discord.enable = true;
                kitty.enable = true;
                st.enable = true;
                anki.enable = true;
                nautilus.enable = true;
                alacritty.enable = true;
                obsidian.enable = true;
            };
            browsers = {
                qutebrowser.enable = true;
            };
            bspwm.enable = true;
            kde.enable = false;
        };
        theme.active = "alucard";
    };
}
