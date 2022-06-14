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
            python.enable = true;
            java.enable = true;
            ocaml.enable = true;
            rust.enable = true;
            tex.enable = true;
            crystal.enable = true;
            scala.enable = true;
            csharp.enable = true;
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
                godot.enable = true;
                blender.enable = true;
            };
            bspwm.enable = false;
            gnome.enable = true;
            kde.enable = false;
        };
        theme.active = "alucard";
    };
}
