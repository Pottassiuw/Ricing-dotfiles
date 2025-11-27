# ╭─────────────────────────────────────────────────────────╮
# │                    ZSH CONFIG MODERNA                   │
# │              Configuração otimizada para dev           │
# ╰─────────────────────────────────────────────────────────╯

# =============================================================================
# CONFIGURAÇÕES BÁSICAS
# =============================================================================

# História otimizada
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Configurações de comportamento
setopt AUTO_CD              # cd automático digitando apenas o diretório
setopt CORRECT             # correção de comandos
setopt NO_BEEP            # sem beeps
setopt GLOB_DOTS          # incluir arquivos ocultos em glob

# Teclas de edição estilo Emacs
bindkey -e

# =============================================================================
# AUTOCOMPLETIONS
# =============================================================================

# Sistema de completions
autoload -Uz compinit
compinit

# Completions melhorados
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# =============================================================================
# ALIASES MODERNOS
# =============================================================================

# Navegação
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Comandos melhorados (se disponíveis)
if command -v exa &> /dev/null; then
    alias ls='exa --color=auto --icons'
    alias la='exa -la --color=auto --icons'
    alias ll='exa -l --color=auto --icons'
    alias tree='exa --tree --color=auto --icons'
else
    alias ls='ls --color=auto'
    alias la='ls -la --color=auto'
    alias ll='ls -l --color=auto'
fi

if command -v bat &> /dev/null; then
    alias cat='bat'
    alias ccat='cat'  # cat original quando necessário
fi

if command -v fd &> /dev/null; then
    alias find='fd'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# Git aliases
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Desenvolvimento
alias v='nvim'
alias vim='nvim'
alias rovo="acli rovodev run"
alias ReObserveStart='cd ~/Projects/ReObserve && pnpm dev'

# Sistema
alias reload='source ~/.zshrc'
alias zshconfig='nvim ~/.zshrc'
alias h='history'
alias j='z'  # zoxide
alias c='clear'

# =============================================================================
# PLUGINS E FERRAMENTAS
# =============================================================================

# Zoxide (navegação inteligente)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# FZF (fuzzy finder)
if command -v fzf &> /dev/null; then
    # Configurações do FZF
    export FZF_DEFAULT_OPTS="
        --height=40%
        --layout=reverse
        --border
        --margin=1
        --padding=1
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6ac,pointer:#f5e0dc
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6ac,hl+:#f38ba8"
    
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    
    # Bindings do FZF
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || true
    source /usr/share/fzf/completion.zsh 2>/dev/null || true
fi

# Autosuggestions
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#666666'
fi

# Syntax highlighting (deve ser carregado por último)
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# =============================================================================
# FUNÇÕES ÚTEIS
# =============================================================================

# Criar e entrar em diretório
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extrair arquivos
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Busca inteligente de processos
pf() {
    ps aux | grep -v grep | grep "$@" -i --color=always
}

# Weather
weather() {
    curl -s "wttr.in/$1"
}

# =============================================================================
# PROMPT
# =============================================================================

# Starship prompt (se disponível)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
else
    # Prompt simples mas informativo
    autoload -Uz vcs_info
    precmd() { vcs_info }
    
    zstyle ':vcs_info:git:*' formats ' (%b)'
    zstyle ':vcs_info:*' enable git
    
    setopt PROMPT_SUBST
    PROMPT='%F{cyan}%n%f@%F{blue}%m%f:%F{yellow}%~%f%F{red}${vcs_info_msg_0_}%f$ '
fi

# =============================================================================
# VARIÁVEIS DE AMBIENTE
# =============================================================================

# Editor padrão
export EDITOR='nvim'
export VISUAL='nvim'

# Cores para ls
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Configuração do BAT
if command -v bat &> /dev/null; then
    export BAT_THEME="Catppuccin-mocha"
fi

# =============================================================================
# PATH E EXPORTS ADICIONAIS
# =============================================================================

# Adicionar diretórios úteis ao PATH se existirem
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

