# 🏠 Dotfiles

Configurações pessoais para Arch Linux com Niri (Wayland) e ferramentas modernas.

## 📋 O que está incluído

### 🖥️ Window Manager & Interface
- **Niri** - Compositor Wayland com tiling dinâmico
- **Waybar** - Barra de status moderna
- **Rofi** - Launcher de aplicações
- **Swaylock** - Bloqueador de tela

### 🛠️ Ferramentas de Terminal
- **Alacritty** - Terminal emulator performático
- **Kitty** - Terminal alternativo com recursos avançados
- **Zsh** - Shell com configurações personalizadas
- **Starship** - Prompt customizado e rápido

### 🎨 Personalização & Mídia
- **Pywal** - Geração automática de temas a partir do wallpaper
- **Cava** - Visualizador de áudio com shaders personalizados
- **btop** - Monitor de sistema moderno

### 💻 Desenvolvimento
- **Neovim** - Editor com configuração completa (Kickstart)
- **Git** - Configurações globais

### 📦 Pacotes Incluídos
- **76 pacotes oficiais** do repositório do Arch
- **9 pacotes do AUR** para funcionalidades extras
- Scripts personalizados para automação

## 🚀 Instalação Rápida

### Para PC recém formatado (instalação completa):
```bash
git clone https://github.com/seu-usuario/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
Selecione a opção `1` para instalação completa.

### Para aplicar apenas os dotfiles:
```bash
cd ~/.dotfiles
./install.sh
```
Selecione a opção `4` para aplicar apenas as configurações.

## 📁 Estrutura do Projeto

```
~/.dotfiles/
├── home/                    # Arquivos para $HOME
│   ├── .config/            # Configurações de aplicações
│   │   ├── alacritty/      # Terminal emulator
│   │   ├── niri/           # Window manager
│   │   ├── nvim/           # Neovim + plugins
│   │   ├── waybar/         # Status bar
│   │   ├── rofi/           # App launcher
│   │   └── ...
│   ├── .local/bin/         # Scripts personalizados
│   ├── .gitconfig          # Configuração global do Git
│   └── .zshrc              # Configuração do Zsh
├── install/                # Listas de pacotes para instalação
│   ├── packages-official.txt
│   ├── packages-aur.txt
│   └── services-user.txt
├── scripts/                # Scripts de automação
│   └── install/
│       ├── install-packages.sh
│       └── setup-services.sh
└── install.sh              # Instalador principal
```

## 🛠️ Instalação Manual

### 1. Instalar pacotes
```bash
cd ~/.dotfiles
./scripts/install/install-packages.sh
```

### 2. Configurar serviços
```bash
./scripts/install/setup-services.sh
```

### 3. Aplicar dotfiles
```bash
stow home
```

## ⚙️ Personalização

### Adicionar novos pacotes
1. Instale o pacote normalmente
2. Para pacotes oficiais: adicione em `install/packages-official.txt`
3. Para pacotes AUR: adicione em `install/packages-aur.txt`
4. Commit as mudanças

### Modificar configurações
1. Edite os arquivos em `home/.config/`
2. As mudanças são aplicadas automaticamente (via symlinks)
3. Commit as mudanças para manter sincronizado

### Backup de configurações atuais
```bash
# Exporta pacotes instalados
pacman -Qqe > install/packages-official.txt
pacman -Qqm > install/packages-aur.txt

# Exporta serviços habilitados
systemctl --user list-unit-files --state=enabled | awk '{print $1}' > install/services-user.txt
```

## 🎯 Keybindings Principais (Niri)

| Ação | Tecla |
|------|-------|
| Terminal | `Mod + Return` |
| App Launcher | `Alt + Space` |
| Lock Screen | `Super + Alt + L` |
| Close Window | `Mod + Q` |
| Focus (vim-style) | `Mod + H/J/K/L` |
| Workspaces | `Mod + 1-9` |
| Volume | `XF86Audio*` |
| Screenshots | `Print` |

## 📖 Aplicações Incluídas

### Essenciais do Sistema
- Firefox/LibreWolf - Navegadores
- btop, htop - Monitores de sistema  
- brightnessctl - Controle de brilho
- pavucontrol - Controle de áudio
- grim, slurp - Screenshots

### Desenvolvimento
- Neovim com Kickstart
- Git com configurações otimizadas
- Base-devel para compilação

### Mídia e Produtividade
- OpenTabletDriver - Suporte para tablets
- Heroic Games Launcher - Jogos Epic/GOG
- Vesktop - Cliente Discord moderno

## 🤝 Contribuição

Sinta-se livre para fazer fork e adaptar às suas necessidades!

1. Fork este repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Crie um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

## 💡 Dicas

- Use `stow -D home` para remover os symlinks
- Execute `stow --restow home` para reaplicar após mudanças
- Mantenha backups das listas de pacotes atualizadas
- Teste as configurações em uma VM antes de aplicar

---

**Feito com ❤️ para Arch Linux + Niri**