#!/bin/bash

set -e  # Sale en caso de error

echo "🔄 Actualizando sistema..."
apt update && apt upgrade -y
apt install -y zsh git curl wget vim locales-all fonts-powerline powerline-fonts  # Fuentes para temas[web:12][web:28]

echo "✅ Verificando Zsh..."
if ! command -v zsh &> /dev/null; then
    apt install -y zsh
fi
echo "Zsh versión: $(zsh --version)"[web:21]

echo "🎨 Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh ya existe."
fi[web:16][page:1]

echo "📦 Instalando plugins de completions..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
CUSTOM_PLUGINS="$ZSH_CUSTOM/plugins"

# zsh-autosuggestions (sugerencias historial)
if [ ! -d "$CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$CUSTOM_PLUGINS/zsh-autosuggestions"
fi[web:7]

# zsh-syntax-highlighting (resaltado sintaxis)
if [ ! -d "$CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$CUSTOM_PLUGINS/zsh-syntax-highlighting"
fi[web:7]

# zsh-completions (+800 completions extras)
if [ ! -d "$CUSTOM_PLUGINS/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions.git "$CUSTOM_PLUGINS/zsh-completions"
fi[web:17][page:0]

echo "🎨 Configurando tema Honukai..."
# Backup .zshrc original
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true

# Configuración completa .zshrc
cat > ~/.zshrc << 'EOF'
# Configuración Zsh + Oh My Zsh + Honukai + Completions
export ZSH="$HOME/.oh-my-zsh"

# Tema Honukai
ZSH_THEME="honukai"

# Plugins (completions + mejoras)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Completions avanzados (evita duplicados)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"

# Historial mejorado
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
EOF[web:17][web:7]

echo "🔧 Estableciendo Zsh como shell predeterminado..."
chsh -s $(which zsh)[web:5][web:10]

echo "✅ ¡INSTALACIÓN COMPLETA!"
echo "Ejecuta: exec zsh"
echo "O reinicia la terminal para ver el tema Honukai con completions."
echo "Prueba: git st<TAB>, apt in<TAB>, docker ps<TAB>"
