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
            haskell.enable = false;
            scheme.enable = true;
            clojure.enable = false;
            python.enable = true;
            java.enable = true;
            ocaml.enable = false;
            rust.enable = true;
            node.enable = true;
            lua.enable = true;
            tex.enable = true;
            crystal.enable = false;
            scala.enable = false;
            csharp.enable = true;
            nix.enable = true;
        };
        desktop = {
            apps = {
                discord.enable = false;
                kitty.enable = true;
                st.enable = false;
                anki.enable = false;
                nautilus.enable = false;
                alacritty.enable = true;
                obsidian.enable = false;
                godot.enable = true;
                blender.enable = true;
                unity3d.enable = true;
            };
            bspwm.enable = false;
            gnome.enable = true;
            kde.enable = false;
        };
        theme.active = "alucard";
    };
}
