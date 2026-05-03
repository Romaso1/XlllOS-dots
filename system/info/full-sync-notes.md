# Full sync notes

Updated: 2026-05-03_04-37-21

This sync copied safe configs from HOME and selected non-secret system configs from /etc.

Not synced by design:

- browser profiles
- passwords/cookies/tokens
- SSH/GPG keys
- keyrings
- VPN/network connection secrets
- game libraries
- Bottles bottle prefixes
- Steam userdata/libraries
- caches/logs/sessions

Main restore script:

```bash
scripts/install-from-current-system-snapshot.sh
```
