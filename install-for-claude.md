# Flow install guide for Claude (or another AI assistant)

You are helping someone install **Flow** on their own Mac or Windows PC and connect it. This note tells you the
steps, what the person must do themselves, and how to fix the usual problems. The plain human version is
https://brocapjames.github.io/flow/install.html.

## What Flow is

A desktop to-do app. It reads the person's Gmail and Google Calendar (with their permission), uses Claude to turn
email into tasks and draft replies, and **only sends anything when the person clicks Send**. It isn't sold or
public: James McGrath (the developer) sets it up for friends, each with an **invite link**. Each person has their own
copy and their own Google sign-in. Their tasks, drafts and attached files are kept in a database James runs, in a
section only their Flow can reach. Their email and Google sign-in stay on their own computer.

## Safety rules for you

- **Never ask the person to paste their invite, a key or any password into the chat.** The invite goes straight
  into Flow (the page's button, or Flow's own setup screen). If they paste it into the chat by mistake, tell them
  to ask James for a new one: an invite works once.
- Don't use `sudo`, don't turn off macOS security (Gatekeeper, SIP), and don't download Flow from anywhere else.
  The only real copies are on https://github.com/brocapjames/flow-releases (which the Mac line below uses).
- Don't edit Flow's settings file (`config.json`) by hand; its keys are encrypted and editing can break them.
- Sign-ins (Google, Apple, Microsoft, Claude) and macOS permission questions are for the person to click.

## What the person should have

1. **An invite link from James**, like `https://brocapjames.github.io/flow/join.html#…`. Opening it shows the same
   steps as here and a button, **Open Flow and join**. It works once and lasts 7 days. If it's missing, used or
   run out, stop and ask James for a new one. Don't try to make one.
2. **Their own Google account.**

Nothing else. The invite brings Flow's database login, its Google sign-in client and, when James shares one, a
Claude key. If Flow's welcome screen still shows a **Claude** step after joining, James hasn't shared a key: the
person needs their own (console.anthropic.com, API keys, starts `sk-ant-`), pasted into that step.

## Mac

Needs: macOS on Apple silicon or Intel, an internet connection, about 10 minutes. Microsoft Office and Google
Drive for desktop are useful but not needed to install.

1. In Terminal: `curl -fsSL https://brocapjames.github.io/flow/mac.sh | bash`
   - It finds the newest Flow on https://github.com/brocapjames/flow-releases, downloads `Flow-for-Mac-<version>.zip`
     to Downloads, unzips it to `~/Downloads/Flow` and runs `install-mac.sh` inside it.
   - That downloads Node.js into `~/.flow-build` (checked against its checksum), installs Flow's libraries, builds
     `Flow.app` for this Mac, puts it in `/Applications` (or `~/Applications`), tidies up and opens Flow.
   - No admin password is needed. About 5 minutes. If you can run shell commands yourself, you may run this line.
   - macOS may ask "Terminal would like to access files in your Downloads folder": **Allow**.
   - It prints "Installing Flow <version>" first. It stops, changing nothing, if the Flow already in Applications
     is some other app with the same name.
2. Join and connect Flow (below).

Optional, for people with a Claude subscription (Pro, Max or higher) who want Flow's regular mail check to run on
it instead of a key:

3. Install Claude Code (skip if `claude --version` already works): `curl -fsSL https://claude.ai/install.sh | bash`
   It goes to `~/.local/bin/claude`, which is where Flow looks (also Homebrew and `/usr/local/bin`).
4. The person signs in: `claude` in Terminal, sign in with their Claude account in the browser, then `/exit`.
5. In Flow: **Show all settings**, **Background work**, tick **Use Claude Code (my Claude subscription) for the mail
   check**, **Save options**.

macOS questions the first time (the person clicks):
- "Flow wants to use your confidential information stored in 'Flow Safe Storage'": Mac password, **Always Allow**.
- Touch ID when Flow opens: that's Flow's lock.
- "Flow wants to control Microsoft Word / Excel / PowerPoint / Messages": **OK**.
- "Flow would like to access data from other apps" or files in Downloads / Google Drive: **Allow**.
- For texts (iMessage): System Settings, Privacy & Security, **Full Disk Access**, **+**, pick Flow, switch it on,
  then quit Flow (the F in the menu bar, Quit) and open it again.

Updating later: Flow says when a new version is out. The F in the menu bar, **Update to Flow <version>**: Flow
downloads it, checks it, builds it (about 5 minutes, Flow stays usable) and restarts by itself. Settings and
sign-ins are kept. If it says it couldn't, the same Terminal line as above does the same job. If Flow can't read
texts after an update although its Full Disk Access switch looks on: in Full Disk Access select Flow, remove it
with **-**, add it again with **+**, then quit and reopen Flow.

## Windows

1. Run `Flow-Setup-<version>.exe`. It installs for this Windows account only (no admin).
2. "Windows protected your PC" (the app isn't code-signed): **More info**, then **Run anyway**.
3. Flow opens.
4. Join and connect Flow (below).

Optional (Claude subscription, as on a Mac): in PowerShell, no admin, `irm https://claude.ai/install.ps1 | iex`;
a new PowerShell window, `claude`, sign in, `/exit`; then tick **Use Claude Code** as in the Mac steps.

Updating later: from version 0.1.3, Flow updates itself (it installs when Flow quits, or from the tray's
**Restart to update**). Older copies: run the new installer James sends. Settings and sign-ins are kept.

## Join and connect Flow (both)

With the invite page's own steps, none of this needs doing by hand: the Mac line carries the invite (Flow reads
it from `~/Library/Application Support/Flow/invite.txt` once and removes it), and on Windows the page's **Get Flow**
button puts the invite on the clipboard, where a new Flow looks once when it first opens. Flow then joins,
opens Google's sign-in in the browser, and after that goes straight to the list. If it didn't join by itself:

A new Flow opens on **Welcome to Flow**, with three short steps:
1. **Your invite**: on the invite link's page click **Open Flow and join** (the browser asks to open Flow: yes).
   Or copy the invite from that page (it starts `flow-invite:`), paste it in the box, **Join**. Flow says
   "You're in" and sets itself up.
2. **Google**: **Connect Google**. The browser opens: sign in with the person's own Google account. "Google
   hasn't verified this app" is expected: **Advanced**, **Go to Flow**, allow everything listed.
3. **You**: their full name, already filled in from the invite: correct it if needed. Claude writes and signs off
   in this name.

**Show all settings** (bottom left) has the rest: what they do (for Claude), time zone, background work, sending
safety, the phone website. None of it is needed to start. A minute after Google is connected Flow reads the last
40 sent emails once and writes a short note on how they write; it's under **Show all settings**, **You**.

Then **Open Flow**. Suggest **Practice mode** (same page) for the first day: everything is checked but
nothing is sent. Flow's mail check runs every 5 minutes from 6am to 10pm; the **Sync** button works any time.

## Flow on their phone (optional)

Flow has a phone website at `https://flow-phone.pages.dev` (shared by everyone's Flow; it holds no data). Tasks and
drafts work any time; email, Claude and sending go through Flow on their computer, which must be on, awake and
online with Flow running. Nothing is sent unless the person taps Send or Pay on the phone. Nothing pops up to confirm:
if Flow's checks notice something, it says what and the same button, tapped again, sends it; a payment to a new payee
needs the tick in the payment first.

Nothing is needed from James: the invite already gave Flow what the phone's link needs.

1. In Flow: **Settings**, **Connections**, **Flow website**.
2. **Connect a phone**: a QR code and a code show for 10 minutes.
3. On the phone: scan the QR code with the camera and open the link. The first time: **First time? Make your
   login**, with their own email and a new password (for the Flow website only; they type it, not you). After that, sign in. A phone's first time has to be the QR
   code (or **Copy the link**, opened on the phone): that's how the website learns whose Flow it's for.
4. **Use Face ID next time?** Yes.
5. App icon: Safari, Share, **Add to Home Screen**. Opened from there the first time, it says "Open Flow from your
   laptop first" with a box: **Connect a phone** again on the computer, **Copy the link**, get it to the phone,
   paste it in the box, sign in.

Keeping the computer awake: under **Flow website**, "Keep this Mac (or laptop) awake while it's plugged in and a
phone is connected" (ticked already on a Mac). A closed lid still sleeps it.

## Fixing problems

| What they see | What to do |
|---|---|
| "Run this from inside the Flow folder" | The zip unpacked somewhere else, or into a nested folder. Find `install-mac.sh` (e.g. `ls ~/Downloads/Flow*`) and run `bash <that path>`. |
| "That invite has already been used" / "has run out" / "Flow doesn't know that invite" | An invite works once, for 7 days. Ask James for a new link. |
| "The invite worked, but Flow couldn't reach the database just now" | Close Flow and open it again. The invite isn't needed a second time. |
| "This Flow is already set up, so the invite wasn't used" | This copy already has a database. If they mean to move it, paste the invite in Connections, step 1 (their old tasks stay in the old database). |
| The page's **Open Flow and join** does nothing | Flow isn't installed yet, or the browser's question was dismissed. Install Flow first; or copy the invite from the page and paste it into Flow. |
| "504", "Gateway Time-out", "download failed" during the build | GitHub's downloads are having trouble. The script already retries twice; run it again in an hour. |
| "The Node.js download didn't match its checksum" | A bad download. Run again later. Don't skip the check. |
| "Node.js doesn't start on this Mac" | `rm -rf ~/.flow-build` and run the installer again. |
| "Flow is still open" | Quit Flow (F in the menu bar, Quit Flow), run again. |
| "Operation not permitted" as soon as the line runs | Terminal wasn't allowed into Downloads. System Settings, Privacy & Security, Files and Folders, Terminal: switch on Downloads. Run again. |
| "a newer one (Flow x) is beside it" | Two Flow folders in Downloads. Run the line the message prints (it points at the newer folder), then put the old folder in the Bin. |
| "Couldn't download Flow's parts" | The internet connection dropped. Run the same line again. |
| "There's already an app called Flow … and it isn't this Flow" | Another app with the same name is in Applications. Rename or move it (the person decides), run again. |
| Flow can't read texts after an update, Full Disk Access looks on | In Full Disk Access select Flow, **-**, then **+** and add Flow again. Quit and reopen Flow. |
| Any other red message from the installer | Send James a screenshot of the whole Terminal window. |
| Database won't connect | Check the internet connection, then close Flow and open it again. If it keeps happening, tell James: the database is his to look at. |
| Claude: key rejected / out of credit | Rejected: a typo or a deleted key, ask James. Out of credit: console.anthropic.com, Billing, add credit. Flow waits and carries on. |
| Google: "Access blocked" or an admin message | A work (Google Workspace) account whose admin blocks outside apps. Use a personal Gmail, or the admin allows Flow. |
| `claude: command not found` after installing Claude Code | Open a new Terminal / PowerShell window and try again. Flow itself finds it in `~/.local/bin` without the PATH. |
| Claude Code says the plan doesn't include it | They need Pro, Max or higher (not the free plan). Until then Flow's mail check uses the API key. |
| Claude Code signed out, or the plan's usage runs out | Nothing breaks: Flow uses the API key for that check and tries Claude Code again 30 minutes later. To sign back in: `claude`, then `/login`. |
| Red "Google disconnected: reconnect" by Sync | Click it and sign in to Google again. |
| **Open Flow** is greyed out | Join with the invite and connect Google first; it also needs a full name. |
| Phone: "Open Flow from your laptop first" | The phone (or its Home Screen copy) hasn't been given the laptop's link yet. Scan the QR code from **Connect a phone**, or paste the copied link in the box on that screen. |
| Phone: "Your laptop isn't answering" | The computer is asleep, off or offline, or Flow isn't running. Open the lid, plug it in, open Flow. Lists and drafts still work meanwhile. |
| Phone: "This phone isn't connected" | **Connect this phone** on the phone, then **Reconnect with Face ID**, or type a new code from **Connect a phone** on the computer. |
| Computer: "Paste your Supabase publishable key above and click Save first" | Step 1 above. The key comes from James. |
| Flow misbehaves later | F in the menu bar (Mac) or tray (Windows), **Open Flow's logs**, send James `flow.log` (and `flow.1.log`). Logs: Mac `~/Library/Application Support/Flow/logs`, Windows `%APPDATA%\Flow\logs`. |

Don't guess beyond this. If something isn't covered, the answer is: send James a screenshot.
