#!/bin/bash

# my_zsh_install.sh - Instalador universal de ZSH (Ubuntu/macOS)
# Autor: Ricardo Wagner (ricardowec51)

set -e

OS_TYPE="$(uname)"
echo "🚀 Sistema detectado: $OS_TYPE"

install_dependencies() {
    if [[ "$OS_TYPE" == "Linux" ]]; then
        echo "🔄 Actualizando sistema (Linux/apt)..."
        sudo apt update
        sudo apt install -y zsh git curl wget vim locales-all fonts-powerline powerline-fonts
    elif [[ "$OS_TYPE" == "Darwin" ]]; then
        echo "🔄 Verificando Homebrew (macOS)..."
        if ! command -v brew >/dev/null 2>&1; then
            echo "❌ Homebrew no encontrado. Instálalo en: https://brew.sh/"
            exit 1
        fi
        brew install zsh git curl coreutils
    else
        echo "❌ Sistema no soportado: $OS_TYPE"
        exit 1
    fi
}

install_dependencies

echo "✅ Verificando Zsh..."
echo "Zsh versión: $(zsh --version)"

echo "🎨 Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh ya existe."
fi

echo "📦 Instalando plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
CUSTOM_PLUGINS="$ZSH_CUSTOM/plugins"

PLUGINS=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions.git"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "zsh-completions|https://github.com/zsh-users/zsh-completions.git"
)

for item in "${PLUGINS[@]}"; do
    plugin="${item%%|*}"
    repo="${item#*|}"

    if [ ! -d "$CUSTOM_PLUGINS/$plugin" ]; then
        echo "Clonando $plugin..."
        git clone "$repo" "$CUSTOM_PLUGINS/$plugin"
    else
        echo "$plugin ya existe."
    fi
done

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Clonando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "Powerlevel10k ya existe."
fi

echo "🎨 Configurando tema Powerlevel10k..."
if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup_$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
fi

cat > "$HOME/.zshrc" << 'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -Uz compinit
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"

HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY

if [[ $(uname) == "Darwin" && $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
EOF

echo "🔧 Cambiando shell predeterminado..."
ZSH_PATH="$(command -v zsh)"
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
    chsh -s "$ZSH_PATH"
fi

echo "✅ ¡INSTALACIÓN COMPLETA!"
echo "1. Ejecuta: exec zsh"
echo "2. O reinicia la terminal para ver Powerlevel10k."
echo "3. Si quieres personalizarlo, ejecuta: p10k configure"

