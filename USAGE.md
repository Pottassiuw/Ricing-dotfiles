# 📖 Guia de Uso - Dotfiles

## 🚀 Instalação Rápida

```bash
# Clone o repositório
git clone <seu-repo> ~/.dotfiles
cd ~/.dotfiles

# Execute o script de instalação
./install.sh
```

## ⌨️ Atalhos Essenciais

### Niri (Gerenciador de Janelas)
| Atalho | Ação |
|--------|------|
| `Mod + T` | Abrir terminal (Alacritty) |
| `Mod + D` | Abrir launcher (Rofi) |
| `Mod + W` | Seletor de wallpaper |
| `Mod + Q` | Fechar janela |
| `Mod + H/J/K/L` | Navegar entre janelas |
| `Mod + Ctrl + H/J/K/L` | Mover janelas |
| `Mod + 1-9` | Trocar workspace |
| `Print` | Screenshot de área |

### Scripts Personalizados
| Script | Função |
|--------|--------|
| `wallpaper-selector` | Trocar wallpaper com interface gráfica |
| `screenshot area/full/clipboard` | Capturar tela |
| `system-info` | Informações do sistema |
| `quick-commands` | Comandos rápidos via rofi |

## 🖼️ Gerenciamento de Wallpapers

### Configuração Inicial
1. Crie o diretório: `mkdir -p ~/Pictures/Wallpapers`
2. Adicione suas imagens favoritas
3. Use `Mod + W` para selecionar

### Comandos
```bash
# Menu interativo
wallpaper-selector

# Wallpaper aleatório
wallpaper-selector random

# Restaurar último wallpaper
wallpaper-selector restore
```

## 📸 Screenshots

```bash
# Área selecionada
screenshot area

# Tela completa  
screenshot full

# Para área de transferência
screenshot clipboard
```

## 🎛️ Rofi - Launcher Avançado

### Modos Disponíveis
- `rofi -show drun`: Aplicações
- `rofi -show run`: Comandos
- `rofi -show window`: Janelas abertas
- `rofi -show filebrowser`: Navegador de arquivos

### Integração com Scripts
```bash
# Comandos rápidos do sistema
rofi -show run -run-command "quick-commands {cmd}"

# Informações do sistema
system-info rofi | rofi -dmenu -p "System Info"
```

## 🔧 Personalização Rápida

### Alterar Tema do Rofi
Edite: `~/.config/rofi/themes/custom.rasi`

### Modificar Atalhos do Niri  
Edite: `~/.config/niri/config.kdl`

### Customizar Terminal
Edite: `~/.config/alacritty/alacritty.toml`

### Configurar Git
```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

## 📁 Estrutura de Diretórios

```
~/
├── .config/
│   ├── alacritty/          # Terminal
│   ├── niri/               # Window Manager
│   ├── rofi/               # Launcher
│   ├── nvim/               # Editor
│   ├── waybar/             # Barra superior
│   └── swaylock/           # Screen lock
├── .local/bin/             # Scripts personalizados
├── Pictures/
│   ├── Wallpapers/         # Seus wallpapers
│   └── Screenshots/        # Capturas de tela
└── .zshrc                  # Configuração do shell
```

## 🔄 Gerenciamento com Stow

```bash
# Aplicar configuração específica
stow alacritty

# Remover configuração
stow -D alacritty

# Reaplicar tudo
stow -R */

# Ver o que seria feito (dry-run)
stow -n alacritty
```

## 🐛 Solução de Problemas

### Script de wallpaper não funciona
```bash
# Verificar dependências
which rofi swaybg

# Verificar permissões
ls -la ~/.local/bin/wallpaper-selector

# Testar manualmente
wallpaper-selector random
```

### Niri não inicia
```bash
# Verificar logs
journalctl -u niri --since today

# Verificar sintaxe da config
niri validate ~/.config/niri/config.kdl
```

### Rofi não aparece
```bash
# Testar tema
rofi -show drun -theme ~/.config/rofi/themes/custom.rasi

# Usar tema padrão
rofi -show drun -theme default
```

## 🎨 Temas e Cores

Baseado no **Catppuccin Mocha**:
- **Background**: `#1e1e2e`
- **Foreground**: `#cdd6f4` 
- **Accent Blue**: `#89b4fa`
- **Red**: `#f38ba8`
- **Green**: `#a6e3a1`
- **Yellow**: `#f9e2af`

## 📚 Recursos Úteis

- [Documentação do Niri](https://github.com/YaLTeR/niri)
- [Manual do Rofi](https://github.com/davatorium/rofi)
- [Guia do Stow](https://www.gnu.org/software/stow/)
- [Oh My Zsh](https://ohmyz.sh/)

---

**Dica**: Mantenha seus dotfiles sempre atualizados fazendo commits regulares das suas personalizações! 🎯