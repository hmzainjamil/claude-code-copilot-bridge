# Security Policy

## Scope and versions

This repository provides a shell wrapper, installer, and Homebrew formula for launching Claude Code through Anthropic direct, a localhost `copilot-api` service, or Ollama. No version-support schedule has been independently verified here. Check the repository's current release and source before upgrading.

## Security behavior visible in source

The `claude-switch` script appends session metadata to `~/.claude/claude-switch.log`, including timestamp, mode, process ID, working directory, provider/model, duration, and exit code. Protect or remove this log if its operational details are sensitive.

The Copilot and Ollama modes set Claude Code's Anthropic-compatible base URL to a local port. The external service behind that port controls onward routing and data handling. Do not assume localhost means prompts remain on the machine.

The installer can place a script under `~/bin`, create alias files, and ask to edit shell startup files. Review it before execution. The Homebrew formula installs a script and documentation and declares dependencies.

## Safe use

- Review scripts and formula before installation or upgrades.
- Keep OAuth state, provider credentials, code, prompts, and logs private.
- Verify the identity, source, and behavior of any local proxy before sending sensitive data.
- Check current provider terms and model availability; these can change.
- Do not rely on unsupported claims of zero logging, guaranteed privacy, or subscription entitlement.

## Reporting

Report vulnerabilities through GitHub's private vulnerability reporting feature if enabled for this repository. Otherwise contact the maintainer through a private channel listed on their GitHub profile. Do not post secrets or exploit details publicly. Include the affected file/version, impact, and safe reproduction steps.

This policy describes observable repository behavior; it is not a security audit or certification.
