# Deployment notes

These notes describe the author's integration experience, not a copy-paste installation guide for upstream software. Refer to each upstream project's current official documentation and terms for supported installation methods.

## Environment

- Oracle Cloud Ubuntu VM
- Linux services managed with systemd
- External LLM endpoints configured using private credentials (never committed)

## Verification commands

```bash
systemctl status napcat --no-pager
journalctl -u napcat -n 50 --no-pager
```

Check service logs for errors, taking care to redact credentials, identifiers and any conversation content before sharing screenshots.

## To complete before publishing

- [ ] Verify exact Ubuntu version and component versions
- [ ] Verify whether AstrBot is running as a service or in another form
- [ ] Add only actual, tested commands to this document
- [ ] Add a redacted demonstration image
