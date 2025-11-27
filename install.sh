#!/bin/bash
# Instalador principal dos dotfiles
# Execute após formatar o PC para restaurar todo o ambiente

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_header() {
    echo -e "${PURPLE}=== $1 ===${NC}"
}

# Banner de boas-vindas
show_banner() {
    echo -e "${PURPLE}"
    echo "██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
    echo "██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
    echo "██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
    echo "██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
    echo "██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
    echo "╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
    echo -e "${NC}"
    echo "🚀 Instalador automático de dotfiles"
    echo "📦 Instala pacotes, configura sistema e aplica dotfiles"
    echo ""
}

# Menu de seleção
show_menu() {
    echo "Escolha uma das opções:"
    echo "1) Instalação completa (recomendado para PC formatado)"
    echo "2) Apenas instalar pacotes"
    echo "3) Apenas configurar serviços"
    echo "4) Apenas aplicar dotfiles (stow)"
    echo "5) Instalação personalizada"
    echo "0) Sair"
    echo ""
    read -p "Digite sua opção [0-5]: " choice
}

# Verifica dependências básicas
check_dependencies() {
    log_info "Verificando dependências básicas..."
    
    if ! command -v git &> /dev/null; then
        log_error "Git não está instalado. Instale primeiro: sudo pacman -S git"
        exit 1
    fi
    
    if ! command -v stow &> /dev/null; then
        log_warning "Stow não está instalado. Instalando..."
        sudo pacman -S --noconfirm stow
    fi
    
    log_success "Dependências básicas verificadas"
}

# Instala pacotes
install_packages() {
    log_header "INSTALANDO PACOTES"
    cd scripts/install
    ./install-packages.sh
    cd ../..
}

# Configura serviços
setup_services() {
    log_header "CONFIGURANDO SERVIÇOS"
    cd scripts/install
    ./setup-services.sh
    cd ../..
}

# Aplica dotfiles com stow
apply_dotfiles() {
    log_header "APLICANDO DOTFILES"
    log_info "Usando stow para criar symlinks..."
    
    # Remove links antigos se existirem
    stow -D . 2>/dev/null || true
    
    # Aplica os dotfiles
    stow --adopt .
    stow --restow .
    
    log_success "Dotfiles aplicados com sucesso!"
    log_info "Seus arquivos de configuração agora são gerenciados pelos dotfiles"
}

# Instalação completa
full_install() {
    log_header "INSTALAÇÃO COMPLETA"
    check_dependencies
    install_packages
    setup_services
    apply_dotfiles
    log_success "🎉 Instalação completa finalizada!"
}

# Instalação personalizada
custom_install() {
    log_header "INSTALAÇÃO PERSONALIZADA"
    check_dependencies
    
    echo "Selecione os componentes para instalar:"
    
    read -p "Instalar pacotes? [y/N]: " install_pkgs
    read -p "Configurar serviços? [y/N]: " setup_svcs
    read -p "Aplicar dotfiles? [y/N]: " apply_dots
    
    [[ $install_pkgs =~ ^[Yy]$ ]] && install_packages
    [[ $setup_svcs =~ ^[Yy]$ ]] && setup_services  
    [[ $apply_dots =~ ^[Yy]$ ]] && apply_dotfiles
    
    log_success "Instalação personalizada concluída!"
}

# Função principal
main() {
    show_banner
    
    while true; do
        show_menu
        
        case $choice in
            1)
                full_install
                break
                ;;
            2)
                check_dependencies
                install_packages
                break
                ;;
            3)
                setup_services
                break
                ;;
            4)
                check_dependencies
                apply_dotfiles
                break
                ;;
            5)
                custom_install
                break
                ;;
            0)
                log_info "Saindo..."
                exit 0
                ;;
            *)
                log_error "Opção inválida! Digite um número de 0 a 5."
                ;;
        esac
    done
    
    echo ""
    log_success "Dotfiles configurados! 🎊"
    log_info "Dicas finais:"
    echo "  • Reinicie o sistema para garantir que tudo funcione"
    echo "  • Execute 'source ~/.zshrc' para carregar o zsh"
    echo "  • Verifique se o niri/waybar estão funcionando"
    echo "  • Personalize as configurações conforme necessário"
}

# Executa se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi