# Generated from Nix

Ces fichiers Lua sont **générés** depuis la configuration nixvim dans
`~/.config/nixos-config/hosts/common/development/nixvim.nix` (branche `feat/nixvim`).

**Phase 1 :** Ces fichiers sont une copie de la config manuelle existante,
fonctionnellement équivalente à ce que produit le module nixvim.

**Phase 2 :** La génération automatique Nix→Lua produira ces fichiers
depuis le module nixvim.  Pour l'instant, ils sont maintenus à la main
et doivent refléter le module nixvim.

## Workflow

1. Modifier `hosts/common/development/nixvim.nix` (source de vérité)
2. `nixos-rebuild switch` (ou `home-manager switch`) pour appliquer sur Nix
3. Mettre à jour ce dossier pour refléter les changements
4. Commiter sur `feat/nixvim-generated`

## Windows

Sur Windows, ces fichiers sont utilisés directement avec `vim.pack`
(Neovim 0.12+).  Sur Nix, c'est nixvim qui gère l'installation des
plugins et la configuration.
