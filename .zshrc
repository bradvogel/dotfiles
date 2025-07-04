# --- Git branch in prompt without any extra plugins ---
autoload -Uz vcs_info           # Built-in zsh helper
precmd()  { vcs_info }          # Runs right before each prompt is drawn
setopt prompt_subst             # Allow variable expansion in PROMPT

# Enable git and check working‑tree state
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes   true   # detect dirty tree
zstyle ':vcs_info:*' stagedstr   ' %F{green}+%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}!%f'

# Branch  ⎇  plus + / ! flags
zstyle ':vcs_info:*' formats ' %F{magenta}⎇ %b%f%c%u'

# Enable approximate completion
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Git completion optimizations
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-*:*' group-order 'main commands' 'alias commands' 'external commands'

PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} $ '

# Change dir
alias dev="cd ~/dev"
alias tmp="cd /tmp"
alias gp="git push"
alias gpf="git push -f"
alias gitsquash='git fetch origin;git rebase -i HEAD~$(git rev-list --count HEAD ^origin/main)'

# Useful for notifying me via audio when a long running command is done, eg: npm test; notifyme
alias notifyme="say 'command finished'"
alertme() {
    message=${1:-"command finished"}
    osascript -e "display alert \"$message\"" >/dev/null 2>&1 &
}
