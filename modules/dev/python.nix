# modules/dev/python.nix --- https://godotengine.org/
#
# Python's ecosystem repulses me. The list of environment "managers" exhausts
# me. The Py2->3 transition make trainwrecks jealous. But SciPy, NumPy, iPython
# and Jupyter can have my babies. Every single one.

{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.python;
in
let
  my-python-packages = python-packages: with python-packages; [
    # pandas
    # vtk
    # pygame
  ];
  mypy = pkgs.python38.withPackages my-python-packages;
in {
  options.modules.dev.python = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      mypy
      virtualenv
      # nodePackages.pyright # lsp and type inference
      # python38Packages.jupyter
      # python38Packages.jupyter_core
      # python38Packages.jupyterlab
      # python38Packages.pip
      # python38Packages.black
      # python38Packages.setuptools
      # python38Packages.pylint
      # python38Packages.poetry
    ];

    env.IPYTHONDIR      = "$XDG_CONFIG_HOME/ipython";
    env.PIP_CONFIG_FILE = "$XDG_CONFIG_HOME/pip/pip.conf";
    env.PIP_LOG_FILE    = "$XDG_DATA_HOME/pip/log";
    env.PYLINTHOME      = "$XDG_DATA_HOME/pylint";
    env.PYLINTRC        = "$XDG_CONFIG_HOME/pylint/pylintrc";
    env.PYTHONSTARTUP   = "$XDG_CONFIG_HOME/python/pythonrc";
    env.PYTHON_EGG_CACHE = "$XDG_CACHE_HOME/python-eggs";
    env.JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";

    environment.shellAliases = {
      py     = "python";
      py2    = "python2";
      py3    = "python3";
      po     = "poetry";
      ipy    = "ipython --no-banner";
      ipylab = "ipython --pylab=qt5 --no-banner";
    };
  };
}
