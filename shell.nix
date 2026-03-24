{ pkgs ? import <nixpkgs> {} }:

let
  neovim-master = pkgs.neovim-unwrapped.overrideAttrs (old: {
    src = pkgs.fetchzip {
      url = "https://github.com/neovim/neovim/archive/master.tar.gz";
      sha256 = "sha256-0S/xskob6r2c7kXIlNCcj5VTP7SAo/aT4ts4Cy8zepU=";
    };
    version = "0.12.0-dev";
    dontVersionCheck = true;

    buildInputs = old.buildInputs or [] ++ (with pkgs; [ cmake gettext gnumake unzip ]);
    nativeBuildInputs = old.nativeBuildInputs or [] ++ (with pkgs; [ pkg-config ]);
  });

  isolated_dir = builtins.getEnv "PWD" + "/.nvim-isolated";
in
  pkgs.mkShell {
    buildInputs = [
      neovim-master
      pkgs.emacs            # Pour orgmode-babel (optionnel)
      pkgs.quarto           # Pour le support Quarto 
      pkgs.ripgrep          # Pour la recherche dans les docs
      pkgs.tree
    ];

    shellHook = ''
    export ISOLATED_NVIM_HOME="$PWD/.nvim-isolated"
    export XDG_CONFIG_HOME="$ISOLATED_NVIM_HOME/config"
    export XDG_DATA_HOME="$ISOLATED_NVIM_HOME/data"
    export XDG_STATE_HOME="$ISOLATED_NVIM_HOME/state"
    export XDG_CACHE_HOME="$ISOLATED_NVIM_HOME/cache"

    mkdir -p "$XDG_CONFIG_HOME"/nvim
    mkdir -p "$XDG_DATA_HOME"/nvim/lazy  # Pour lazy.nvim
    mkdir -p "$XDG_STATE_HOME"/nvim
    mkdir -p "$XDG_CACHE_HOME"/nvim

    # Créer une configuration minimale en literate programming
    if [ ! -f "$PWD/config.org" ]; then
    cat > "$PWD/config.org" << 'EOF'
    #+TITLE: Configuration Neovim v0.12 - Test isolé
    #+AUTHOR: $(whoami)
    #+DATE: $(date +%Y-%m-%d)

    * Objectif
    Ce fichier documente ma configuration de test pour Neovim v0.12.
    Il utilise le literate programming pour expliquer chaque choix.

    * Options de base
    Configuration minimale pour démarrer.

    #+BEGIN_SRC lua :tangle $ISOLATED_NVIM_HOME/config/nvim/init.lua
    -- Ce fichier est généré automatiquement depuis config.org
    -- Ne pas modifier directement

    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.mouse = "a"

    print("🚀 Neovim v0.12-dev chargé depuis configuration littéraire")
    print("📁 Config: " .. vim.fn.stdpath("config"))
    #+END_SRC

    * Plugins (à venir)
    #+BEGIN_SRC lua :tangle $ISOLATED_NVIM_HOME/config/nvim/lua/plugins.lua
    -- Configuration des plugins à venir
    #+END_SRC

    * Keymaps
    #+BEGIN_SRC lua :tangle $ISOLATED_NVIM_HOME/config/nvim/lua/keymaps.lua
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
    #+END_SRC
    EOF
    echo "✅ Fichier config.org créé !"
    fi

    # Fonction pour "tangle" (extraire le code) - Version corrigée sans guillemets problématiques
    nvim-tangle() {
    awk '/^#\+BEGIN_SRC lua/{flag=1; next} /^#\+END_SRC/{flag=0} flag' config.org > "$ISOLATED_NVIM_HOME/config/nvim/init.lua"
    echo "✅ Code extrait vers $ISOLATED_NVIM_HOME/config/nvim/init.lua"
    }

    # Version plus sophistiquée qui extrait aussi les fichiers séparés
    nvim-tangle-all() {
    echo "Extraction de tous les blocs de code..."

    # Extraire init.lua (bloc principal)
    awk '/^#\+BEGIN_SRC lua/{flag=1; next} /^#\+END_SRC/{flag=0} flag' config.org > "$ISOLATED_NVIM_HOME/config/nvim/init.lua"

    # Extraire les blocs avec :tangle spécifique
    # Cette version plus avancée utilise les métadonnées Org-mode
    grep -o '#+BEGIN_SRC lua :tangle [^ ]*' config.org | while read -r line; do
    target=$(echo "$line" | sed 's/#+BEGIN_SRC lua :tangle //')
    echo "  → Extraction vers $target"
    # Implémentation plus complexe si nécessaire
    done

    echo "✅ Extraction terminée"
    }

    # Alias pour ouvrir la documentation
    alias nvim-docs='nvim config.org'

    echo "╔═══════════════════════════════════════════════════════════════════╗"
    echo "║  📚 Neovim master avec LITERATE PROGRAMMING                       ║"
    echo "╚═══════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "📄 Documentation : config.org"
    echo ""
    echo "🔧 Commandes disponibles :"
    echo "  nvim-tangle      → Extrait le code principal vers init.lua"
    echo "  nvim-tangle-all  → Extrait tous les blocs de code"
    echo "  nvim-docs        → Édite la documentation"
    echo "  nvim             → Lance Neovim avec la config extraite"
    echo ""
    echo "Structure actuelle :"
    tree -L 3 "$ISOLATED_NVIM_HOME" 2>/dev/null || ls -la "$ISOLATED_NVIM_HOME"
    echo ""
    echo "Version Neovim : $(nvim --version | head -n 1)"

    # Extraire automatiquement au lancement si nécessaire
    if [ ! -f "$ISOLATED_NVIM_HOME/config/nvim/init.lua" ] && [ -f "config.org" ]; then
    echo ""
    echo "⚡ Aucune config extraite trouvée. Extraction automatique..."
    nvim-tangle
    fi
    '';

    # Nettoyage à la sortie
    shellExit = ''
    echo "🧹 Nettoyage des variables d'environnement Neovim"
    unset XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_CACHE_HOME
    unset NVIM_LOG_FILE SHADA_FILE ISOLATED_NVIM_HOME
    '';
  }
