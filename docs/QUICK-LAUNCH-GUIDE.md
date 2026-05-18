# Guide Rapide: Lancement et Test

## 🚀 Alias pour Lancer le Fork

### Ajouter l'alias

Ouvre ton `~/.zshrc` :

```bash
nano ~/.zshrc
```

Ajoute à la fin :

```bash
# Alias pour lancer copilot-api fork (PR #170 - Codex support)
alias ccunified='~/Sites/perso/cc-copilot-bridge/scripts/launch-unified-fork.sh'
```

Recharge la config :

```bash
source ~/.zshrc
```

### Utilisation

```bash
# Lancer le fork (simple !)
ccunified

# Le script vérifie automatiquement:
# ✅ Si PR #170 est mergée (affiche warning si oui)
# ✅ Si port 4141 est libre
# ✅ Si fork est à jour
# ✅ Si build existe
```

**Si la PR est mergée**, le script affichera :

```
╔════════════════════════════════════════════════════════════════╗
║  ⚠️  WARNING: This fork is no longer necessary!               ║
╚════════════════════════════════════════════════════════════════╝

What to do:
  1. Stop this fork: pkill -f 'copilot-api'
  2. Update official: npm update -g copilot-api
  3. Start official: copilot-api start
  4. Test Codex: COPILOT_MODEL=gpt-5.2-codex ccc -p 'Test'

Continue launching fork anyway? (y/N)
```

---

## 🧪 Tester Tous les Modèles

### Méthode 1: Script Automatique (Recommandé)

```bash
# Lancer le fork (terminal 1)
ccunified

# Dans un autre terminal, tester tous les modèles
cd ~/Sites/perso/cc-copilot-bridge
./scripts/test-all-models.sh
```

**Ce script teste automatiquement les 42 modèles** et affiche ✅/❌ pour chacun.

### Méthode 2: Commandes Individuelles

Voir la liste complète dans : `docs/ALL-MODEL-COMMANDS.md`

**Tests Rapides:**

```bash
# Codex Premium
COPILOT_MODEL=gpt-5.2-codex ccc -p "Write a Python function"

# Codex Mini (rapide)
COPILOT_MODEL=gpt-5.1-codex-mini ccc -p "Quick question"

# Claude Sonnet (référence)
COPILOT_MODEL=claude-sonnet-4-6 ccc -p "Write a Python function"

# GPT-4.1 (alternative)
COPILOT_MODEL=gpt-4.1 ccc -p "Write a Python function"

# Gemini 2.5 (stable)
COPILOT_MODEL=gemini-2.5-pro ccc -p "Write a Python function"
```

---

## 📋 Workflow Complet

### Setup Initial (Une fois)

```bash
# 1. Cloner le fork si pas déjà fait
git clone https://github.com/caozhiyuan/copilot-api.git ~/src/copilot-api-responses
cd ~/src/copilot-api-responses
git checkout feature/responses-api
bun install
bun run build

# 2. Ajouter l'alias
echo "alias ccunified='~/Sites/perso/cc-copilot-bridge/scripts/launch-unified-fork.sh'" >> ~/.zshrc
source ~/.zshrc
```

### Usage Quotidien

**Terminal 1 (Fork):**
```bash
ccunified
# Laisser tourner
```

**Terminal 2 (Travail):**
```bash
# Avec variable
COPILOT_MODEL=gpt-5.2-codex ccc -p "Create a REST API"

# Ou avec alias (si configurés dans ~/.zshrc)
ccc-codex -p "Create a REST API"
ccc-codex-mini -p "Quick question"
```

---

## 🎯 Aliases Recommandés

Ajoute aussi ces aliases Codex dans ton `~/.zshrc` :

```bash
# Modèles Codex (nécessite fork PR #170)
alias ccc-codex='COPILOT_MODEL=gpt-5.2-codex claude-switch copilot'
alias ccc-codex-std='COPILOT_MODEL=gpt-5.1-codex claude-switch copilot'
alias ccc-codex-mini='COPILOT_MODEL=gpt-5.1-codex-mini claude-switch copilot'
alias ccc-codex-max='COPILOT_MODEL=gpt-5.1-codex-max claude-switch copilot'
```

Recharge :

```bash
source ~/.zshrc
```

Utilisation :

```bash
# Fork lancé avec: ccunified

# Utiliser directement les alias
ccc-codex -p "Write a React component"
ccc-codex-mini -p "Quick question"
ccc-codex-max -p "Complex algorithm"
```

---

## 🛑 Arrêter le Fork

```bash
# Stopper le fork
pkill -f "copilot-api"

# Relancer copilot-api officiel
copilot-api start

# Tester avec modèle non-Codex
ccc-sonnet -p "Hello"
```

---

## 📊 Vérifier les Modèles Disponibles

```bash
# Avec fork lancé
curl -s http://localhost:4141/v1/models | jq -r '.data[].id' | grep codex

# Doit afficher:
# gpt-5.2-codex
# gpt-5.1-codex
# gpt-5.1-codex-mini
# gpt-5.1-codex-max
# gpt-5-codex
```

---

## 🔍 Dépannage

### "command not found: ccunified"

```bash
# Vérifier l'alias
alias | grep ccunified

# Si vide, ajouter et recharger
echo "alias ccunified='~/Sites/perso/cc-copilot-bridge/scripts/launch-unified-fork.sh'" >> ~/.zshrc
source ~/.zshrc
```

### "Port 4141 already in use"

```bash
# Identifier le process
lsof -i :4141

# Stopper
pkill -f "copilot-api"

# Relancer
ccunified
```

### Fork ne démarre pas

```bash
# Vérifier le fork
cd ~/src/copilot-api-responses
git status
git checkout feature/responses-api
bun run build

# Relancer
ccunified
```

---

## 📝 Résumé Ultra-Rapide

**Setup (une fois):**
```bash
echo "alias ccunified='~/Sites/perso/cc-copilot-bridge/scripts/launch-unified-fork.sh'" >> ~/.zshrc
source ~/.zshrc
```

**Lancer fork:**
```bash
ccunified  # Terminal 1
```

**Tester modèles:**
```bash
# Terminal 2
COPILOT_MODEL=gpt-5.2-codex ccc -p "Test"  # Codex
COPILOT_MODEL=claude-sonnet-4-6 ccc -p "Test"  # Claude
```

**Arrêter:**
```bash
pkill -f "copilot-api"
```

---

## 📚 Documentation Complète

- **Toutes les commandes:** `docs/ALL-MODEL-COMMANDS.md` (42 modèles)
- **Script de test auto:** `./scripts/test-all-models.sh`
- **Rapports de test:** `debug-responses-api/test-summary-20260123.md`

---

**C'est tout !** 🎉

Avec `ccunified`, tu lances le fork en une commande. Le script vérifie automatiquement si la PR est mergée et t'avertit si le fork n'est plus nécessaire.
