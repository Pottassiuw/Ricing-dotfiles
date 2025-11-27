#!/bin/bash
# Script para configurar serviços do sistema após instalação dos pacotes

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

# Habilita serviços de usuário
setup_user_services() {
    local services_file="../../install/services-user.txt"
    
    if [[ ! -f "$services_file" ]]; then
        log_warning "Arquivo de serviços de usuário não encontrado: $services_file"
        return 0
    fi

    log_info "Configurando serviços de usuário..."
    
    while IFS= read -r service; do
        [[ -z "$service" ]] && continue
        [[ "$service" =~ ^[[:space:]]*# ]] && continue
        
        log_info "Habilitando serviço de usuário: $service"
        systemctl --user enable "$service" || log_warning "Falha ao habilitar: $service"
    done < "$services_file"
    
    log_success "Serviços de usuário configurados"
}

# Configurações específicas do sistema
setup_system_configs() {
    log_info "Configurando ajustes do sistema..."
    
    # Habilitar multilib (para jogos e aplicações 32-bit)
    if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
        log_info "Habilitando multilib no pacman.conf..."
        echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
        sudo pacman -Sy
    fi
    
    # Configurar sudoers para não pedir senha para comandos específicos (opcional)
    # Descomente se necessário:
    # echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/brightnessctl, /usr/bin/systemctl" | sudo tee /etc/sudoers.d/$USER
    
    log_success "Configurações do sistema aplicadas"
}

# Configurar Git globalmente (se ainda não configurado)
setup_git() {
    log_info "Verificando configuração do Git..."
    
    if ! git config --global user.name &> /dev/null; then
        read -p "Digite seu nome para o Git: " git_name
        git config --global user.name "$git_name"
    fi
    
    if ! git config --global user.email &> /dev/null; then
        read -p "Digite seu email para o Git: " git_email
        git config --global user.email "$git_email"
    fi
    
    log_success "Git configurado"
}

# Configurar zsh como shell padrão
setup_zsh() {
    if [[ "$SHELL" != *"zsh"* ]]; then
        log_info "Configurando zsh como shell padrão..."
        chsh -s $(which zsh)
        log_warning "Faça logout e login novamente para usar o zsh"
    else
        log_success "Zsh já é o shell padrão"
    fi
}

main() {
    log_info "=== CONFIGURAÇÃO DE SERVIÇOS E SISTEMA ==="
    
    setup_user_services
    setup_system_configs
    setup_git
    setup_zsh
    
    log_success "=== CONFIGURAÇÃO CONCLUÍDA ==="
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi