# Deployment notes

## Context

A personal test deployment on an Oracle Cloud free-tier Ubuntu VM. Components: upstream AstrBot and NapCat, a QQ client session, and selected third-party LLM API endpoints.

These notes document concepts and operations from the project. They are **not** an automated, independently tested install guide; vendor and framework versions can change.

## Workflow used

1. Prepared an Ubuntu VM on Oracle Cloud and accessed it using the usual administrative workflow.
2. Installed and configured the upstream applications using their published installation guidance. See upstream links in `THIRD_PARTY.md` rather than cloning their source into this repository.
3. Configured the OneBot v11 messaging connection between NapCat and AstrBot. Refer to the [AstrBot OneBot guide](https://docs.astrbot.app/en/platform/aiocqhttp.html) for connection details.
4. Added external LLM API provider settings in the chatbot application, without exposing credentials in this repository.
5. Used `systemd` to manage the NapCat service and inspected status and journal logs when troubleshooting.
6. Tested QQ chat messages, response generation and API requests; reviewed quotas and latency.

## Observed service control

In the original Ubuntu deployment, a `napcat` systemd service was observed. These are the operations used to inspect and restart it:

```bash
sudo systemctl status napcat
sudo journalctl -u napcat -n 80 --no-pager
sudo systemctl restart napcat
```

The observed service launched QQ through `xvfb-run`; the illustrative example in `examples/napcat.service.example` must **not** be treated as the actual installed service unit. Verify local executable paths and systemd options before reuse.

## Network and security

Keep dashboard and OneBot connection ports private; if remote administration is essential, prefer SSH tunnelling or another authenticated private-access mechanism rather than exposing default WebUI ports. Use least-privilege cloud firewall rules and rotate leaked keys.

## Environment-specific details intentionally excluded

- server public IP and instance identifiers
- QQ ID, login QR and client cookies/session files
- third-party provider keys, tokens and account identifiers
- live `settings.json`, systemd override files and raw logs

## Limits

No automated installation, reproducible infrastructure-as-code, production monitoring, formal security review or original full-stack application is claimed. Neither uptime metrics nor response-time benchmarks are claimed because they were not collected in a reproducible test.
