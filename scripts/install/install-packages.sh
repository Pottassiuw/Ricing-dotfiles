#!/bin/bash
# Script para instalar todos os pacotes automaticamente após formatação

set -e  # Sai se qualquer comando falhar

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções de log
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

# Verifica se está no Arch Linux
check_arch() {
    if ! command -v pacman &> /dev/null; then
        log_error "Este script é para Arch Linux. Pacman não encontrado."
        exit 1
    fi
    log_success "Sistema Arch Linux detectado"
}

# Atualiza o sistema
update_system() {
    log_info "Atualizando sistema..."
    sudo pacman -Syu --noconfirm
    log_success "Sistema atualizado"
}

# Instala pacotes oficiais
install_official_packages() {
    local packages_file="../../install/packages-official.txt"
    
    if [[ ! -f "$packages_file" ]]; then
        log_error "Arquivo de pacotes oficiais não encontrado: $packages_file"
        return 1
    fi

    log_info "Instalando pacotes oficiais..."
    
    # Lê o arquivo e instala os pacotes
    while IFS= read -r package; do
        [[ -z "$package" ]] && continue  # Pula linhas vazias
        [[ "$package" =~ ^[[:space:]]*# ]] && continue  # Pula comentários
        
        if ! pacman -Qq "$package" &> /dev/null; then
            log_info "Instalando: $package"
            sudo pacman -S --noconfirm "$package" || log_warning "Falha ao instalar: $package"
        else
            log_info "Já instalado: $package"
        fi
    done < "$packages_file"
    
    log_success "Pacotes oficiais processados"
}

# Instala AUR helper (paru)
install_aur_helper() {
    if command -v paru &> /dev/null; then
        log_success "Paru já está instalado"
        return 0
    fi

    log_info "Instalando paru (AUR helper)..."
    
    # Dependências para compilar
    sudo pacman -S --needed --noconfirm base-devel git
    
    # Clone e instala paru
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/paru
    
    log_success "Paru instalado com sucesso"
}

# Instala pacotes do AUR
install_aur_packages() {
    local packages_file="../../install/packages-aur.txt"
    
    if [[ ! -f "$packages_file" ]]; then
        log_warning "Arquivo de pacotes AUR não encontrado: $packages_file"
        return 0
    fi

    if ! command -v paru &> /dev/null; then
        log_error "Paru não está instalado. Instale primeiro o AUR helper."
        return 1
    fi

    log_info "Instalando pacotes do AUR..."
    
    while IFS= read -r package; do
        [[ -z "$package" ]] && continue
        [[ "$package" =~ ^[[:space:]]*# ]] && continue
        
        if ! paru -Qq "$package" &> /dev/null; then
            log_info "Instalando do AUR: $package"
            paru -S --noconfirm "$package" || log_warning "Falha ao instalar do AUR: $package"
        else
            log_info "Já instalado (AUR): $package"
        fi
    done < "$packages_file"
    
    log_success "Pacotes do AUR processados"
}

# Função principal
main() {
    log_info "=== INSTALADOR AUTOMÁTICO DE PACOTES ==="
    log_info "Iniciando instalação automatizada..."
    
    check_arch
    update_system
    install_official_packages
    install_aur_helper
    install_aur_packages
    
    log_success "=== INSTALAÇÃO CONCLUÍDA ==="
    log_info "Reinicie o sistema para garantir que tudo funcione corretamente."
}

# Executa se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi