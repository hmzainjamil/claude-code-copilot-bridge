# Installation Options

The installer respects your shell configuration and offers multiple integration methods.

## Quick Install (Interactive)

```bash
curl -fsSL https://raw.githubusercontent.com/FlorianBruniaux/cc-copilot-bridge/main/install.sh | bash
```

The installer will:
1. Download `claude-switch` to `~/bin/`
2. Create `~/.claude/aliases.sh` with all aliases
3. **ASK** if you want automatic `.zshrc` modification

**Default choice**: Manual setup (option 2)

## Integration Methods

### 1. Standard Shell (zsh/bash)

**Automatic** (if you chose option 1 during install):
```bash
# Already added to your .zshrc/.bashrc:
source ~/.claude/aliases.sh
```

**Manual**:
```bash
echo 'source ~/.claude/aliases.sh' >> ~/.zshrc
source ~/.zshrc
```

### 2. Antigen (Recommended for Managed Configs)

Add to your `.zshrc`:
```bash
# Claude Code Multi-Provider
antigen bundle ~/.claude/aliases.sh
```

Then reload:
```bash
source ~/.zshrc
```

### 3. Oh-My-Zsh

Create a custom plugin:
```bash
ln -s ~/.claude/aliases.sh $ZSH_CUSTOM/plugins/claude-switch.plugin.zsh
```

Add to `.zshrc` plugins:
```bash
plugins=(... claude-switch)
```

Reload:
```bash
source ~/.zshrc
```

### 4. Zinit

Add to `.zshrc`:
```bash
zinit light ~/.claude/aliases.sh
```

### 5. Zgen

Add to `.zshrc`:
```bash
zgen load ~/.claude/aliases.sh
```

### 6. Sheldon

Add to `~/.config/sheldon/plugins.toml`:
```toml
[plugins.claude-switch]
local = "~/.claude"
use = ["aliases.sh"]
```

## Manual Installation (Security-Conscious)

If you prefer to review before running:

### 1. Download Script
```bash
mkdir -p ~/bin
curl -fsSL https://raw.githubusercontent.com/FlorianBruniaux/cc-copilot-bridge/main/claude-switch -o ~/bin/claude-switch
chmod +x ~/bin/claude-switch
```

### 2. Generate Aliases
```bash
mkdir -p ~/.claude
curl -fsSL https://raw.githubusercontent.com/FlorianBruniaux/cc-copilot-bridge/main/scripts/generate-aliases.sh -o ~/.claude/generate-aliases.sh
bash ~/.claude/generate-aliases.sh
```

### 3. Integrate (Choose Your Method Above)

## Uninstall

Remove all components:
```bash
# Remove script
rm ~/bin/claude-switch

# Remove aliases file
rm ~/.claude/aliases.sh

# Remove from shell config (if auto-installed)
# Edit ~/.zshrc or ~/.bashrc and remove:
#   source ~/.claude/aliases.sh

# Remove logs (optional)
rm ~/.claude/claude-switch.log
```

## Aliases Provided

### Core Commands
- `ccd` - Anthropic Direct
- `ccc` - GitHub Copilot (default: Claude Sonnet 4.5)
- `cco` - Ollama Local (default: devstral-small-2)
- `ccs` - Status check (all providers)

### Copilot Model Shortcuts
- `ccc-opus` - Claude Opus 4.5
- `ccc-sonnet` - Claude Sonnet 4.5
- `ccc-haiku` - Claude Haiku 4.5
- `ccc-gpt` - GPT-4.1
- `ccc-gemini` - Gemini 2.5 Pro
- `ccc-gemini3` - Gemini 3 Flash Preview
- `ccc-gemini3-pro` - Gemini 3 Pro Preview

### Ollama Model Shortcuts
- `cco-devstral` - Devstral Small 2 (best agentic)
- `cco-granite` - IBM Granite4 Small (70% less VRAM)

### Experimental (Unified Fork)
- `ccunified` - Launch unified copilot-api fork
- `ccc-codex` - GPT-5.2 Codex
- `ccc-codex-mini` - GPT-5.1 Codex Mini

## PATH Configuration

The aliases file adds `~/bin` to your PATH:
```bash
export PATH="$HOME/bin:$PATH"
```

If you already manage your PATH elsewhere, you can remove this line from `~/.claude/aliases.sh`.

## Why This Approach?

**Respects your configuration management**:
- No surprise modifications to `.zshrc`/`.bashrc`
- Works with modern plugin managers (antigen, oh-my-zsh, zinit)
- Single source of truth: `~/.claude/aliases.sh`
- Easy to disable: just don't source the file
- Easy to customize: edit one file

**Clean uninstall**:
- Remove one line from shell config
- Delete one directory (`~/.claude`)
- No scattered modifications

## Troubleshooting

### Aliases not found after install

**Symptoms**: `command not found: ccd`

**Solution**: You need to source the aliases file. See [Integration Methods](#integration-methods) above.

### Conflicting aliases

**Symptoms**: `ccc` already exists (e.g., Clear Compiled Cache)

**Solution**: Edit `~/.claude/aliases.sh` and rename conflicting aliases:
```bash
alias cccode='claude-switch copilot'  # Instead of ccc
```

### Antigen not loading

**Symptoms**: Antigen doesn't recognize `~/.claude/aliases.sh`

**Solution**: Antigen expects `.plugin.zsh` extension. Create a symlink:
```bash
ln -s ~/.claude/aliases.sh ~/.claude/claude-switch.plugin.zsh
antigen bundle ~/.claude/claude-switch.plugin.zsh
```
