# Claude Code Provider Switcher

`claude-switch` is a Bash wrapper for launching Claude Code in one of three configured modes: Anthropic direct, GitHub Copilot through a local `copilot-api` service, or Ollama through its local API. It also offers a provider status check.

This repository is an integration project. Review its scripts, dependencies, third-party services, and applicable provider terms before use. Model availability and subscription terms change over time; this README makes no cost or entitlement promise.

## Modes

| Mode | Behavior | Local service |
|---|---|---|
| `direct` / `d` | Runs Claude Code with Anthropic base URL unset | Anthropic API access configured in your environment |
| `copilot` / `c` | Sets Claude Code's Anthropic-compatible endpoint to localhost and passes a selected model | `copilot-api` on port 4141 |
| `ollama` / `o` | Sets the endpoint to localhost and selects the configured Ollama model | Ollama on port 11434 |
| `status` / `s` | Checks provider connectivity and displays recent session log lines | Depends on local setup |

The script's defaults and model aliases are implementation details. Check the current help and documentation for exact behavior.

## Install

Use the repository's [QUICKSTART.md](QUICKSTART.md) for the maintained installation steps. The repository includes an installer that can write `~/bin/claude-switch`, create `~/.claude/aliases.sh`, and ask to modify shell startup files. Review [install.sh](install.sh) before running it.

The [Homebrew formula](Formula/cc-copilot-bridge.rb) declares `netcat` plus optional Ollama and Node dependencies. Verify the formula and upstream release before installing.

## Use

After installation, the script supports commands such as:

```bash
claude-switch --help
claude-switch status
claude-switch direct
claude-switch copilot
claude-switch ollama
```

The Copilot path expects a separately running `copilot-api` service on localhost port 4141. The Ollama path expects Ollama on localhost port 11434 and a configured model. Neither service is included as an implementation in this repository.

## Repository map

| Path | Purpose |
|---|---|
| [claude-switch](claude-switch) | Provider selection, environment setup, health checks, session logging, Claude Code launch |
| [install.sh](install.sh) | Shell installer and alias setup |
| [Formula/cc-copilot-bridge.rb](Formula/cc-copilot-bridge.rb) | Homebrew formula |
| [docs/ALL-MODEL-ALIASES.sh](docs/ALL-MODEL-ALIASES.sh) | Optional shell aliases for model selection |
| [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) | Troubleshooting guide |
| [SECURITY.md](SECURITY.md) | Existing security guidance, reviewed and corrected alongside this README |

## Data and security

The script appends local session metadata to `~/.claude/claude-switch.log`, including mode, process ID, current working directory, provider/model, elapsed time, and exit code. Do not assume the log excludes all sensitive operational details.

In Copilot and Ollama modes, Claude Code prompts and context are sent to the configured local service, which may then route them to another provider. Confirm the service's implementation and provider data practices before sending confidential code or customer data. A localhost endpoint does not by itself prove that processing stays local.

The installer edits user-level files. Review requested changes before accepting them. Protect local credentials and logs, and do not commit tokens, private prompts, or customer information.

See [SECURITY.md](SECURITY.md).

## Verification and limits

The Homebrew formula defines two smoke checks for version output and shell aliases. Their presence does not establish that the full provider integrations work. No test or compatibility claim is made here.

Claude Code, provider APIs, model IDs, Copilot terms, Ollama, and third-party proxy behavior can change. Validate the current setup before relying on it.
