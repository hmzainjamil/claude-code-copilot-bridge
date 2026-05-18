#!/usr/bin/env bash
# Aliases pour tous les modèles copilot-api
# À copier dans ~/.bash_aliases ou ~/.zshrc

#############################################################################################
# CC COPILOT BRIDGE - ALL MODELS ALIASES
#############################################################################################

# Base aliases
alias ccd='claude-switch direct'
alias ccc='claude-switch copilot'
alias cco='claude-switch ollama'
alias ccs='claude-switch status'

# Fork launcher (PR #170)
alias ccunified='~/Sites/perso/cc-copilot-bridge/scripts/launch-unified-fork.sh'

#############################################################################################
# CODEX MODELS (5) - Nécessite fork PR #170
#############################################################################################

alias ccc-codex='COPILOT_MODEL=gpt-5.2-codex claude-switch copilot'
alias ccc-codex-std='COPILOT_MODEL=gpt-5.1-codex claude-switch copilot'
alias ccc-codex-mini='COPILOT_MODEL=gpt-5.1-codex-mini claude-switch copilot'
alias ccc-codex-max='COPILOT_MODEL=gpt-5.1-codex-max claude-switch copilot'
alias ccc-codex-legacy='COPILOT_MODEL=gpt-5-codex claude-switch copilot'

#############################################################################################
# GPT-5 SERIES (4)
#############################################################################################

alias ccc-gpt52='COPILOT_MODEL=gpt-5.2 claude-switch copilot'
alias ccc-gpt51='COPILOT_MODEL=gpt-5.1 claude-switch copilot'
alias ccc-gpt5='COPILOT_MODEL=gpt-5 claude-switch copilot'
alias ccc-gpt5-mini='COPILOT_MODEL=gpt-5-mini claude-switch copilot'

#############################################################################################
# GPT-4 SERIES (13)
#############################################################################################

# GPT-4.1
alias ccc-gpt41='COPILOT_MODEL=gpt-4.1 claude-switch copilot'
alias ccc-gpt41-dated='COPILOT_MODEL=gpt-4.1-2025-04-14 claude-switch copilot'
alias ccc-gpt41-copilot='COPILOT_MODEL=gpt-41-copilot claude-switch copilot'

# GPT-4o
alias ccc-gpt4o='COPILOT_MODEL=gpt-4o claude-switch copilot'
alias ccc-gpt4o-nov='COPILOT_MODEL=gpt-4o-2024-11-20 claude-switch copilot'
alias ccc-gpt4o-aug='COPILOT_MODEL=gpt-4o-2024-08-06 claude-switch copilot'
alias ccc-gpt4o-may='COPILOT_MODEL=gpt-4o-2024-05-13 claude-switch copilot'
alias ccc-gpt4o-mini='COPILOT_MODEL=gpt-4o-mini claude-switch copilot'
alias ccc-gpt4o-mini-jul='COPILOT_MODEL=gpt-4o-mini-2024-07-18 claude-switch copilot'
alias ccc-gpt4o-preview='COPILOT_MODEL=gpt-4-o-preview claude-switch copilot'

# GPT-4 Base
alias ccc-gpt4='COPILOT_MODEL=gpt-4 claude-switch copilot'
alias ccc-gpt4-jun='COPILOT_MODEL=gpt-4-0613 claude-switch copilot'
alias ccc-gpt4-jan='COPILOT_MODEL=gpt-4-0125-preview claude-switch copilot'

#############################################################################################
# GPT-3.5 SERIES (2)
#############################################################################################

alias ccc-gpt35='COPILOT_MODEL=gpt-3.5-turbo claude-switch copilot'
alias ccc-gpt35-jun='COPILOT_MODEL=gpt-3.5-turbo-0613 claude-switch copilot'

#############################################################################################
# CLAUDE MODELS (5)
#############################################################################################

alias ccc-opus='COPILOT_MODEL=claude-opus-4-6 claude-switch copilot'
alias ccc-opus41='COPILOT_MODEL=claude-opus-41 claude-switch copilot'
alias ccc-sonnet='COPILOT_MODEL=claude-sonnet-4-6 claude-switch copilot'
alias ccc-sonnet4='COPILOT_MODEL=claude-sonnet-4 claude-switch copilot'
alias ccc-haiku='COPILOT_MODEL=claude-haiku-4.5 claude-switch copilot'

#############################################################################################
# GEMINI MODELS (3)
#############################################################################################

alias ccc-gemini3-pro='COPILOT_MODEL=gemini-3-pro-preview claude-switch copilot'
alias ccc-gemini3-flash='COPILOT_MODEL=gemini-3-flash-preview claude-switch copilot'
alias ccc-gemini='COPILOT_MODEL=gemini-2.5-pro claude-switch copilot'

#############################################################################################
# OTHER MODELS (2)
#############################################################################################

alias ccc-grok='COPILOT_MODEL=grok-code-fast-1 claude-switch copilot'
alias ccc-oswe='COPILOT_MODEL=oswe-vscode-prime claude-switch copilot'

#############################################################################################
# OLLAMA MODELS (Locaux)
#############################################################################################

alias cco-devstral='OLLAMA_MODEL=devstral-small-2 claude-switch ollama'
alias cco-granite='OLLAMA_MODEL=ibm/granite4:small-h claude-switch ollama'

#############################################################################################
# RACCOURCIS PAR USAGE
#############################################################################################

# Production / Qualité maximale
alias ccc-prod='ccc-opus'

# Daily development / Équilibré
alias ccc-dev='ccc-sonnet'

# Quick questions / Rapide
alias ccc-quick='ccc-haiku'

# Code generation premium
alias ccc-code='ccc-codex'

# Alternative perspective
alias ccc-alt='ccc-gpt41'

# Private / Offline
alias ccc-private='cco-devstral'

#############################################################################################
# NOTES
#############################################################################################

# Modèles Codex (ccc-codex*) nécessitent le fork PR #170:
#   Lancer avec: ccunified
#
# Modèles Ollama (cco-*) nécessitent Ollama:
#   brew install ollama
#   brew services restart ollama
#   ollama pull devstral-small-2
#
# Usage:
#   ccc-codex -p "Write a function"
#   ccc-sonnet -p "Explain this code"
#   ccc-quick -p "Quick question"
