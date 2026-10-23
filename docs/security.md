# Public repository safety checklist

Before publishing:

- [ ] Search **all files and Git history** for keys, passwords, bearer tokens, private URLs, QQ IDs, personal names, cookies and login material.
- [ ] Do not upload live AstrBot/NapCat directories, QQ session data, cloud credentials, private SSH keys or `.env` files.
- [ ] Redact screenshots and crop out cloud account information, IPs, authentication QR codes and personal conversations.
- [ ] Avoid raw `journalctl`/application logs: they may contain account identifiers, cookies or message contents.
- [ ] Ensure any server address or test URL refers only to `localhost` or a documented placeholder.
- [ ] Verify scripts against your local environment before marking them "tested".
- [ ] Check AstrBot's AGPL/EULA, NapCat's special licence and QQ's platform terms before expanding the project.
- [ ] If a credential was ever committed, **rotate it** and clean the Git history; deleting the current file is insufficient.

The smoke test uses an environment variable, but a local shell environment is not a high-security vault. Use a proper secret manager for production deployments.
