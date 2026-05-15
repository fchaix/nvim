{ pkgs ? import <nixpkgs> {} }:

let
  unstable = import (fetchTarball "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz") {};
  pythonWithPackages = pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
    pip
  ]);
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    codex
    pythonWithPackages
  ] ++ [
    unstable.neovim
  ];

  shellHook = ''
    if [ ! -d ".venv" ]; then
      echo "Creation de l'environnement virtuel Python..."
      ${pythonWithPackages}/bin/python -m venv .venv
    fi

    source .venv/bin/activate

    if ! pip show graphifyy >/dev/null 2>&1; then
      echo "Installation de graphify..."
      pip install graphifyy
    fi

    echo "Environnement pret ! Python : $(python --version)"
    echo "Neovim : $(nvim --version | head -n 1)"
  '';
}
