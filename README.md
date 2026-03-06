# my_zsh_install.sh 🚀

Este script instala de forma automatizada **Zsh**, **Oh My Zsh**, el potente tema **Powerlevel10k** y una selección de plugins esenciales para una experiencia de terminal superior.

## 💻 Soporte Multiplataforma

Ahora el script es compatible con:

- **Ubuntu 22.04+** (vía `apt`)
- **macOS** (vía `brew`) - _Optimizado para Apple Silicon (M1/M2/M3/M4)_

## 📦 Características

- Instalación de dependencias (git, curl, fonts).
- Configuración de plugins:
  - `zsh-autosuggestions`: Sugerencias basadas en historial.
  - `zsh-syntax-highlighting`: Resaltado de comandos en tiempo real.
  - `zsh-completions`: Completado avanzado para +800 herramientas.
- Tema **Powerlevel10k** preconfigurado (el más rápido y personalizable).
- Soporte automático para rutas de **Homebrew** en Mac ARM64.

## 🔡 Fuentes recomendadas

Para que los iconos de Powerlevel10k se vean correctamente, se recomienda instalar las fuentes **MesloLGS NF**:

- [MesloLGS NF Regular.ttf](https://github.com/romkatv/dotfiles-public/raw/master/dotfiles/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold.ttf](https://github.com/romkatv/dotfiles-public/raw/master/dotfiles/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic.ttf](https://github.com/romkatv/dotfiles-public/raw/master/dotfiles/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/dotfiles-public/raw/master/dotfiles/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf)

## 🚀 Instalación rápida (One-Liner)

Si quieres instalar todo con un solo comando sin descargar el archivo manualmente, usa:

### En macOS / Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/ricardowec51/my_zsh_install.sh/main/my_zsh_install.sh | bash
```

---

## 🛠️ Instalación Manual (Paso a paso)

### En Ubuntu / Debian:

```bash
wget https://raw.githubusercontent.com/ricardowec51/my_zsh_install.sh/main/my_zsh_install.sh
chmod +x my_zsh_install.sh
./my_zsh_install.sh
```

### En macOS:

1. Asegúrate de tener instalado [Homebrew](https://brew.sh/).
2. Ejecuta:

```bash
curl -O https://raw.githubusercontent.com/ricardowec51/my_zsh_install.sh/main/my_zsh_install.sh
chmod +x my_zsh_install.sh
./my_zsh_install.sh
```

---

_Autor: [ricardowec51](https://github.com/ricardowec51)_
