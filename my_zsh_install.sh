#!/bin/bash

# my_zsh_install.sh - Instalador universal de ZSH (Ubuntu/macOS)
# Autor: Ricardo Wagner (ricardowec51)
# Adaptado por: Antigravity AI

set -e

# Detección del Sistema Operativo
OS_TYPE="$(uname)"
echo "🚀 Sistema detectado: $OS_TYPE"

install_dependencies() {
    if [[ "$OS_TYPE" == "Linux" ]]; then
        echo "🔄 Actualizando sistema (Linux/apt)..."
        sudo apt update && sudo apt upgrade -y
        sudo apt install -y zsh git curl wget vim locales-all fonts-powerline powerline-fonts
    elif [[ "$OS_TYPE" == "Darwin" ]]; then
        echo "🔄 Verificando Homebrew (macOS)..."
        if ! command -v brew &> /dev/null; then
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
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh ya existe."
fi

echo "📦 Instalando plugins de completions..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
CUSTOM_PLUGINS="$ZSH_CUSTOM/plugins"

# Plugins de la comunidad
declare -A PLUGINS=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
)

for plugin in "${!PLUGINS[@]}"; do
    if [ ! -d "$CUSTOM_PLUGINS/$plugin" ]; then
        echo "Clonando $plugin..."
        git clone "${PLUGINS[$plugin]}" "$CUSTOM_PLUGINS/$plugin"
    fi
done

echo "🎨 Configurando tema Honukai..."
if [ -f "$HOME/.zshrc" ]; then
    cp ~/.zshrc ~/.zshrc.backup_$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
fi

cat > ~/.zshrc << 'EOF'
# Configuración Zsh + Oh My Zsh + Honukai + Completions 
# Generado por my_zsh_install.sh
export ZSH="$HOME/.oh-my-zsh"

# Tema Honukai
ZSH_THEME="honukai"

# Plugins activos
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Completions avanzados
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"

# Historial
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY

# Soporte para Homebrew en macOS ARM64 (M1/M2/M3/M4)
if [[ $(uname) == "Darwin" && $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
EOF

echo "🔧 Cambiando shell predeterminado..."
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s $(which zsh)
fi

echo "✅ ¡INSTALACIÓN COMPLETA!"
echo "Instrucciones finales:"
echo "1. Ejecuta: exec zsh"
echo "2. O reinicia la terminal para ver el tema Honukai."
echo "Prueba: git st<TAB>, docker ps<TAB>"
