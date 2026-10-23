# Self-hosted AI Chatbot — Cloud Deployment & Integration

> **Personal infrastructure and integration case study**, not a new chatbot framework. The bot uses existing third-party software. This repository documents my deployment work and contains independently written operational examples; it **does not** redistribute AstrBot, NapCat, QQ, or third-party model code.

## Overview

I deployed and configured a QQ-connected AI chatbot on an **Oracle Cloud Ubuntu virtual machine**. I integrated the existing [AstrBot](https://github.com/AstrBotDevs/AstrBot) framework, [NapCat](https://github.com/NapNeko/NapCatQQ) messaging adapter, and external LLM APIs. I used AI assistance for Linux commands and troubleshooting, then ran tests and investigated practical issues such as service restarts, authentication persistence, model quotas and response latency.

**My contribution:** server setup, application installation/configuration, integration, service operation and troubleshooting. **Not my contribution:** the upstream chatbot software, its message protocol implementation, or the LLMs. Deployment was AI-assisted, and I do not claim to have written the upstream application code.

### Technology

`Oracle Cloud` · `Ubuntu Linux` · `systemd` · `AstrBot` · `NapCat` · `OneBot v11` · `LLM APIs` · `curl` · `Python (JSON formatting/test tooling)`

## Architecture

```text
QQ client
   | QQ messaging connection (third-party NapCat implementation)
   v
NapCat (third-party; QQ / OneBot v11 adapter)
   | OneBot v11 WebSocket connection
   v
AstrBot (third-party chatbot framework)
   | HTTPS API requests
   v
Configured LLM provider (e.g. Gemini / DeepSeek)

Oracle Cloud Ubuntu VM: hosts the local chatbot components.
systemd: starts, restarts and reports the status of the NapCat service.
```

> The diagram is conceptual; exact process boundaries, network endpoints, and provider routing depend on the deployed configuration. Do not expose NapCat, AstrBot administration interfaces or WebSocket ports publicly without appropriate access controls.

## What I did

- Provisioned and operated an Oracle Cloud Ubuntu environment for a self-hosted chatbot.
- Installed and configured two independent upstream projects, AstrBot and NapCat, to connect QQ messages to an AI response workflow.
- Configured and tested model API endpoints and authentication (without storing secrets here).
- Used `systemctl`, `journalctl`, and application logs to investigate restarts and login/session persistence.
- Compared API responses and investigated quota errors and slow responses with alternative models/providers.
- Used ChatGPT to help draft shell commands, understand logs, and troubleshoot unfamiliar Linux infrastructure; I executed and evaluated the commands myself.

**Scope:** This is a small personal integration/deployment exercise, not a production-ready SaaS application, a from-scratch software development project, or a claim of official QQ integration.

## Demo

A short, redacted screenshot or video of the working bot can be added to `assets/` after reviewing the content for personal data, QR codes, tokens, addresses, server IPs, account IDs and user messages. No live URL is published and none is required to understand the deployment.

## Operations examples

These examples are original, minimal operational helpers, **not** a complete installer. Review names and paths for your own environment before running.

```bash
# Ubuntu: view service health
sudo systemctl status napcat --no-pager

# Read recent logs (may include personal data; don't publish raw output)
sudo journalctl -u napcat -n 60 --no-pager

# Restart only when intentionally troubleshooting
sudo systemctl restart napcat
```

- [`scripts/service-health.sh`](scripts/service-health.sh): inspect status of selected systemd services.
- [`scripts/llm-api-smoke-test.sh`](scripts/llm-api-smoke-test.sh): optional local OpenAI-compatible API test, reading the key from an environment variable.
- [`examples/napcat.service.example`](examples/napcat.service.example): **illustrative** systemd unit with placeholders, not a copy of a verified live unit.
- [`docs/deployment-notes.md`](docs/deployment-notes.md): deployment approach, boundary between upstream software and local configuration.
- [`docs/troubleshooting.md`](docs/troubleshooting.md): investigated issues and limitations.
- [`docs/security.md`](docs/security.md): safe sharing checklist.
- [`THIRD_PARTY.md`](THIRD_PARTY.md): credits and licensing notices.

## Example local API check

For an already running, **trusted** OpenAI-compatible endpoint, supply your own environment variables:

```bash
export LLM_BASE_URL='http://127.0.0.1:18900'
export LLM_MODEL='YOUR_MODEL_ID'
read -r -s -p 'API key: ' LLM_API_KEY; echo
export LLM_API_KEY
./scripts/llm-api-smoke-test.sh
unset LLM_API_KEY
```

The observed local endpoint and one model ID in the original testing session are omitted here to avoid falsely presenting them as stable, public services. Do not run untrusted remote endpoints with valuable API credentials.

## Reflections

- Making an existing application run reliably requires more than installing it: configuration, authentication, service lifecycle, logging and API behaviour matter.
- Free-tier and free-model options require testing for quotas, latency and reliability rather than assuming that a successful response means dependable operation.
- AI assistance accelerates setup, but commands and answers still need validation against logs and observed behaviour.
- My next steps would be a small independently written health-check tool and a more reproducible deployment script, **after testing them on the VM**. These are not claimed as completed features.

## Credits, copyright and limits

This repository **does not contain** source or binaries from AstrBot or NapCat. See [`THIRD_PARTY.md`](THIRD_PARTY.md) for copyright, upstream links, licences and a discussion of permitted use. Each upstream component remains subject to **its own** licence and applicable platform rules. No affiliation with QQ, AstrBot, NapCat, Oracle, Google or DeepSeek is implied.

The repository's original prose and helper scripts are made available under the [MIT License](LICENSE) as specified there; that licence **does not apply** to linked upstream software or proprietary services. AI assistance was used in producing commands and documentation.
