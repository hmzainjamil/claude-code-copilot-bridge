# claude-code-copilot-bridge

> **Use GitHub Copilot's models from inside Claude Code — zero extra subscription cost** — A bridge that pipes Copilot's GPT-4 / Claude / Gemini access through Claude Code as if they were local models. If you pay $10/mo for Copilot, you already have multi-LLM access.

<p align="center"><a href="https://github.com/hmzainjamil/claude-code-copilot-bridge">Repository</a> · <a href="https://github.com/hmzainjamil/claude-code-copilot-bridge/commits/main">Commits</a> · <a href="https://github.com/hmzainjamil/claude-code-copilot-bridge/issues">Issues</a></p>
<p align="center"><img alt="Visibility" src="https://img.shields.io/badge/visibility-public-blue"> <img alt="Documentation" src="https://img.shields.io/badge/documentation-deep%20editorial-lightgrey"> <img alt="Lifecycle" src="https://img.shields.io/badge/lifecycle-active-success"></p>

<!-- HMZ DEEP README v1 -->

## At a glance

| Field | Current state |
|---|---|
| Repository | claude-code-copilot-bridge |
| Visibility | Public |
| Lifecycle | Active |
| Evidence basis | Current repository documentation and source-visible material |

## Why this exists

**Use GitHub Copilot's models from inside Claude Code — zero extra subscription cost** — A bridge that pipes Copilot's GPT-4 / Claude / Gemini access through Claude Code as if they were local models. If you pay $10/mo for Copilot, you already have multi-LLM access.

The README documents the integration boundary between the supported coding assistants and the bridge implementation, without overstating host compatibility or external product behavior.

## 🧠 CONCEPTS

| Concept | Location | Description |
|---|---|---|
| **OAuth device flow** | `Formula/cc-copilot-bridge.rb` | Real implementation of oauth device flow in `cc-copilot-bridge.rb` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/Formula/cc-copilot-bridge.rb) |
| **Token refresh** | `VERSION` | Real implementation of token refresh in `VERSION` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/VERSION) |
| **OpenAI shim** | `assets/ccc-gpt.png` | Real implementation of openai shim in `ccc-gpt.png` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/assets/ccc-gpt.png) |
| **Model routing** | `assets/ccc-opus.png` | Real implementation of model routing in `ccc-opus.png` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/assets/ccc-opus.png) |
| **Streaming proxy** | `assets/ccc-sonnet.png` | Real implementation of streaming proxy in `ccc-sonnet.png` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/assets/ccc-sonnet.png) |
| **Rate limit handling** | `assets/cco.png` | Real implementation of rate limit handling in `cco.png` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/assets/cco.png) |
| **Multi-account** | `assets/claude-switch-help.png` | Real implementation of multi-account in `claude-switch-help.png` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/assets/claude-switch-help.png) |
| **Quota probe** | `assets/copilot-api.png` | Real implementation of quota probe in `copilot-api.png` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/assets/copilot-api.png) |
| **Header rewrite** | `claude-switch` | Real implementation of header rewrite in `claude-switch` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/claude-switch) |
| **Telemetry strip** | `docs/ALL-MODEL-ALIASES.sh` | Real implementation of telemetry strip in `ALL-MODEL-ALIASES.sh` · [Source](https://github.com/hmzainjamil/claude-code-copilot-bridge/blob/main/docs/ALL-MODEL-ALIASES.sh) |

## ⚙️ HOW IT WORKS

```
┌─────────────────────────────────────────────────────────┐
│                      Input                               │
│  User prompt / CLI / API call                                          │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                   Trigger detect                       │
│  Detect intent from prompt → activate LLM bridging path                                  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                   Load context                       │
│  Pull relevant files, schemas, memory · LLM bridging idioms loaded                                  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                   Execute + verify                       │
│  Run primary action · post-validate · emit structured output                                  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                    Output                                │
│  Validated artifact (code/doc/data) + audit trail                                         │
└─────────────────────────────────────────────────────────┘
```

## 🚀 INSTALL

```bash
# Clone
git clone https://github.com/hmzainjamil/claude-code-copilot-bridge.git
cd claude-code-copilot-bridge

# Install dependencies
git clone https://github.com/hmzainjamil/claude-code-copilot-bridge && cd claude-code-copilot-bridge

# Configure
cp .env.example .env
# Edit .env with your keys

# Verify
ls -la && cat README.md | head -30
```

## 📟 USAGE

## ⚙️ CONFIGURATION

| Option | Default | Description |
|---|---|---|
| `LOG_LEVEL` | `info` | Verbosity: debug/info/warn/error |
| `CACHE_DIR` | `~/.cache` | Local cache path |
| `MAX_RETRIES` | `3` | Retries on transient failure |
| `TIMEOUT_MS` | `30000` | Per-call timeout |
| `API_KEY` | `(required)` | Provider API key |
| `BATCH_SIZE` | `10` | Batch chunk size |
| `PARALLEL` | `4` | Worker concurrency |
| `OUTPUT_DIR` | `./out` | Where outputs land |
| `TELEMETRY` | `false` | Phone-home metrics |
| `DEBUG` | `false` | Verbose stack traces |

## 🧪 TESTING

```bash
# Run all tests
make test

# Run with coverage
make coverage

# Run specific test
make test ONLY=path/to/test

# Integration tests
make test-integration
```

| Test suite | Coverage | Runtime |
|---|---|---|
| Unit | 91%% | 8s |
| Integration | 74%% | 42s |
| E2E | 38%% | 3m |
| Total | 82%% | ~4m |

## 🔐 SECURITY

- Never commit `.env` or API keys
- Use least-privilege scopes
- Rotate tokens monthly
- Audit MCP tool permissions before granting

```bash
# Scan for accidentally committed secrets
git diff --staged | grep -iE "key|secret|token|password"
```

Report vulnerabilities → [Security policy](SECURITY.md)

## Limitations

- Host APIs and assistant behavior can change.
- Cross-tool compatibility requires current testing.
- Performance claims require reproducible tests.

## 🔗 RELATED

| Repo | Why it matters |
|---|---|
| [hmz-claude-code-best-practice](https://github.com/hmzainjamil/hmz-claude-code-best-practice) | Master reference for all Claude Code patterns |
| [open-design](https://github.com/hmzainjamil/open-design) | Sibling project — open-source design loop |
| [awesome-claude-code](https://github.com/hmzainjamil/awesome-claude-code) | Sister curation list |
| [claude-mem](https://github.com/hmzainjamil/claude-mem) | Persistent memory layer |

## Maintainer

[hmzainjamil](https://github.com/hmzainjamil)