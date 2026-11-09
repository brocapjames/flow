# Flow install guide for Claude (or another AI assistant)

You are helping someone install **Flow** on their own Mac or Windows PC and connect it. This note tells you the
steps, what the person must do themselves, and how to fix the usual problems. The plain human version is
https://brocapjames.github.io/flow/install.html.

## What Flow is

A desktop to-do app. It reads the person's Gmail and Google Calendar (with their permission), uses Claude to turn
email into tasks and draft replies, and **only sends anything when the person clicks Send**. It isn't sold or
public: James McGrath (the developer) sets it up for friends. Each person has their own copy, their own database,
their own Claude key and their own Google sign-in. James can't see their email.

## Safety rules for you

- **Never ask the person to paste the database line, the Claude key, the Google file's contents or any password
  into the chat.** They paste them straight into Flow's own setup screen. If they paste one into the chat by
  mistake, tell them to ask James for a new one (the Claude key can be replaced at console.anthropic.com, API keys).
- Don't use `sudo`, don't turn off macOS security (Gatekeeper, SIP), and don't download Flow from anywhere else.
  The only real copy is the file James gave them.
- Don't edit Flow's settings file (`config.json`) by hand; its keys are encrypted and editing can break them.
- Sign-ins (Google, Apple, Microsoft, Claude) and macOS permission questions are for the person to click.

## What the person should have from James

1. Flow itself: `Flow-for-Mac-<version>.zip` (Mac) or `Flow-Setup-<version>.exe` (Windows).
2. The database line: one line starting `postgresql://` (a Supabase "session pooler" address with its password).
3. A Claude API key: starts `sk-ant-`.
4. The Google file: a `.json` file (Flow's Google sign-in client).

If any is missing, stop and ask James. Don't try to make your own.

## Mac

Needs: macOS on Apple silicon or Intel, an internet connection, about 10 minutes. Microsoft Office and Google
Drive for desktop are useful but not needed to install.

1. Unzip the zip in **Downloads**, giving `~/Downloads/Flow` (with `install-mac.sh` and `package.json` inside).
2. In Terminal: `bash ~/Downloads/Flow/install-mac.sh`
   - It downloads Node.js into `~/.flow-build` (checked against its checksum), installs Flow's libraries, builds
     `Flow.app` for this Mac, puts it in `/Applications` (or `~/Applications`), tidies up and opens Flow.
   - No admin password is needed. About 5 minutes. If you can run shell commands yourself, you may run this line.
3. Connect Flow (below).

macOS questions the first time (the person clicks):
- "Flow wants to use your confidential information stored in 'Flow Safe Storage'": Mac password, **Always Allow**.
- Touch ID when Flow opens: that's Flow's lock.
- "Flow wants to control Microsoft Word / Excel / PowerPoint / Messages": **OK**.
- "Flow would like to access data from other apps" or files in Downloads / Google Drive: **Allow**.
- For texts (iMessage): System Settings, Privacy & Security, **Full Disk Access**, **+**, pick Flow, switch it on,
  then quit Flow (the F in the menu bar, Quit) and open it again.

Updating later: unzip the new zip into Downloads (replace the old Flow folder) and run the same Terminal line.
Settings and sign-ins are kept.

## Windows

1. Run `Flow-Setup-<version>.exe`. It installs for this Windows account only (no admin).
2. "Windows protected your PC" (the app isn't code-signed): **More info**, then **Run anyway**.
3. Flow opens. Connect Flow (below).

Updating later: from version 0.1.3, Flow updates itself (it installs when Flow quits, or from the tray's
**Restart to update**). Older copies: run the new installer James sends. Settings and sign-ins are kept.

## Connect Flow (both)

Flow opens on **Connections**, four numbered parts:
1. **Database**: paste the database line, **Connect**. Flow sets up its own tables on first connect.
2. **Claude**: paste the key, **Save**. Flow checks the key works and the account has credit.
3. **Google**: **Load from file…**, pick the `.json` file, then **Connect Google**. The browser opens: sign in
   with the person's own Google account. "Google hasn't verified this app" is expected: **Advanced**, **Go to
   Flow**, allow everything listed.
4. **About you**: their full name (and first name if it isn't the first word) and a sentence about their work.
   Claude writes and signs off in this name. **Open Flow** stays off until a name is saved.

Then **Open Flow**. Suggest **Practice mode** (Settings, Connections) for the first day: everything is checked and
confirmed but nothing is sent.

Optional, Mac or Windows: with a Claude Pro or Max subscription, Flow's mail check can run on Claude Code instead
of the API key. Install Claude Code (Mac: `curl -fsSL https://claude.ai/install.sh | bash`), run `claude` once and
sign in, then in Flow: Settings, Background work, tick **Use Claude Code**, Save.

## Fixing problems

| What they see | What to do |
|---|---|
| "Run this from inside the Flow folder" | The zip unpacked somewhere else, or into a nested folder. Find `install-mac.sh` (e.g. `ls ~/Downloads/Flow*`) and run `bash <that path>`. |
| "504", "Gateway Time-out", "download failed" during the build | GitHub's downloads are having trouble. The script already retries twice; run it again in an hour. |
| "The Node.js download didn't match its checksum" | A bad download. Run again later. Don't skip the check. |
| "Node.js doesn't start on this Mac" | `rm -rf ~/.flow-build` and run the installer again. |
| "Flow is still open" | Quit Flow (F in the menu bar, Quit Flow), run again. |
| Any other red message from the installer | Send James a screenshot of the whole Terminal window. |
| Database won't connect, or "paused" | Check the line was pasted whole (starts `postgresql://`, no spaces). A free Supabase project pauses after 7 days unused: supabase.com/dashboard, the project, **Restore project**. Flow reconnects by itself. |
| Claude: key rejected / out of credit | Rejected: a typo or a deleted key, ask James. Out of credit: console.anthropic.com, Billing, add credit. Flow waits and carries on. |
| Google: "Access blocked" or an admin message | A work (Google Workspace) account whose admin blocks outside apps. Use a personal Gmail, or the admin allows Flow. |
| Red "Google disconnected: reconnect" by Sync | Click it and sign in to Google again. |
| **Open Flow** is greyed out | About you needs a full name, saved. |
| Flow misbehaves later | F in the menu bar (Mac) or tray (Windows), **Open Flow's logs**, send James `flow.log` (and `flow.1.log`). Logs: Mac `~/Library/Application Support/Flow/logs`, Windows `%APPDATA%\Flow\logs`. |

Don't guess beyond this. If something isn't covered, the answer is: send James a screenshot.
