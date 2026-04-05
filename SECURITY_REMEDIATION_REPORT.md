# Security Remediation Report

**Date:** 2026-04-05  
**Repo:** tranlynhathao/dotfiles (public)  
**Backup branch:** `security/pre-remediation-backup`  
**Audited by:** Claude Code (gitleaks + manual verification)

---

## Summary

No secrets exist in the current HEAD after remediation.  
One historical secret (Raycast session token) remains in git history and requires a history rewrite + force-push before the repo is fully safe to be public. See Section 4.

---

## 1. Risk Classification

### 1a — Exposed in git history (public repo)

| Secret | Type | File | Commits | Status |
|--------|------|------|---------|--------|
| `wZEdw3xP****boIE` | Raycast user session token | `.config/raycast/config.json` | `e7b06bc` (added) → `f0038a6` (removed) | **Must rewrite history** |
| `c8ff37b9****b6f1` | Raycast/Linear OAuth default clientId | `.config/raycast/extensions/*/` | `610bdd29`–`83db2c05` (removed `d537714`) | Low risk — Raycast-owned public default, not a personal secret |
| `11912017****4312` | Asana OAuth default clientId | `.config/raycast/extensions/*/` | Same as above | Low risk — public app clientId |

### 1b — Local-only (ignored, never committed)

| File | Secret Type | Severity |
|------|-------------|----------|
| `zsh/.openai.env` | OpenAI API key (`sk-proj-****`) | High — rotate key |
| `.config/rclone/rclone.conf` | 6 Google OAuth refresh tokens | High — revoke via Google |
| `.config/gcloud/legacy_credentials/.../adc.json` | Google OAuth refresh token | Medium — run `gcloud auth revoke` |
| `.config/gcloud/credentials.db` | Google OAuth refresh token (SQLite) | Medium — same as above |
| `.config/github-copilot/apps.json` | GitHub User OAuth token (`ghu_****`) | Medium — revoke in GitHub settings |

### 1c — False positives (confirmed)

| File | Finding | Reason |
|------|---------|--------|
| `.config/atuin/config.toml:134` | Secret Keyword | Comment text listing secret pattern names |
| `zsh/.zshrc:277` | Secret Keyword | `alias pwd="pwd \| lolcat"` — keyword match on `pwd` | <!-- pragma: allowlist secret -->
| `nvim/lua/plugins/spec/hop.lua:12` | Base64 High Entropy | `keys = "etovxqpdygfblzhckisuran"` — keyboard layout string | <!-- pragma: allowlist secret -->
| `.secrets.baseline` hex hashes | Generic API Key | SHA hashes stored by detect-secrets, not real secrets |

---

## 2. Changes Made in This Remediation

### Untracked from version control

| File | Reason |
|------|--------|
| `.config/cursor/cli-config.json` | Machine-local app state: contains personal email, userId, authId, statsig session data |
| `.config/gatsby/config.json` | Machine-local app state: contains auto-generated machineId UUID |
| `.config/nushell/history.txt` | Shell command history — machine-local state |

### Added to .gitignore

- `.config/cursor/cli-config.json`
- `.config/gatsby/config.json`
- `.config/nushell/history.txt`

### New files created

| File | Purpose |
|------|---------|
| `zsh/.openai.env.example` | Template showing expected format; safe to commit; real file stays ignored |

---

## 3. Required Manual Actions (in priority order)

### 3a — Rotate/Revoke credentials NOW

1. **OpenAI API key** (`sk-proj-****PxYA`)  
   → platform.openai.com → API Keys → Delete key → Create new  
   → Store new key in macOS Keychain or 1Password, not in a plaintext file

2. **Raycast session token** (`wZEdw3xP****boIE`) — in public git history  
   → Raycast app → Settings → Account → Sign out and back in (this invalidates the old token)

3. **Google rclone refresh tokens** (6 accounts)  
   → myaccount.google.com → Security → Third-party apps → rclone → Revoke  
   → Re-authenticate: `rclone config reconnect <remote>:`

4. **Google ADC refresh token**  
   → Run: `gcloud auth revoke && gcloud auth login`

5. **GitHub Copilot OAuth token** (`ghu_****HZRm`)  
   → github.com → Settings → Applications → Authorized OAuth Apps → GitHub Copilot → Revoke

### 3b — Git history rewrite (do AFTER revoking above)

The backup branch `security/pre-remediation-backup` preserves the original history.

**Only target:** `.config/raycast/config.json` (Raycast session token in `e7b06bc`)  
The Raycast extensions paths contain only public Raycast-owned clientIds — not personal secrets — and do not require rewriting unless you prefer a clean history.

**Command to run locally:**
```bash
# Ensure you are on main and working tree is clean
git checkout main
git status   # should be clean

# Rewrite history to remove the file from all commits
git filter-repo --path .config/raycast/config.json --invert-paths

# Verify the secret is gone
git log --all --oneline -- ".config/raycast/config.json"
# Expected: no output

# Verify HEAD is intact
git log --oneline -5
```

**Then force-push (only when ready to go public):**
```bash
# Re-add remote (filter-repo removes it as a safety measure)
git remote add origin https://github.com/tranlynhathao/dotfiles.git

# Force push all refs
git push origin --force --all
git push origin --force --tags
```

**After force-push:**
- Open a GitHub support request to purge cached views of old commits
- Notify anyone who has cloned the repo to re-clone

---

## 4. Final Safety Assessment

| Check | Status |
|-------|--------|
| Current HEAD contains secrets | No |
| Secret files are git-ignored | Yes |
| Optional secret-loading is graceful | Yes (`[ -f ~/.openai.env ] && source`) |
| Local secret files are rotation candidates | Yes — see Section 3a |
| Safe to push current HEAD publicly | **Yes, with one caveat** |
| Caveat | Raycast token in git history — do history rewrite first |
| Safe after history rewrite + credential rotation | **Yes** |
