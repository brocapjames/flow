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

They also need their own **Claude subscription** (Pro, Max or higher; the free plan doesn't include Claude Code).
Flow's regular mail check runs on it through **Claude Code**; the API key covers drafts, document reviews, Chat,
and the mail check whenever Claude Code isn't available.

## Mac

Needs: macOS on Apple silicon or Intel, an internet connection, about 10 minutes. Microsoft Office and Google
Drive for desktop are useful but not needed to install.

1. Unzip the zip in **Downloads**, giving `~/Downloads/Flow` (with `install-mac.sh` and `package.json` inside).
2. In Terminal: `bash ~/Downloads/Flow/install-mac.sh`
   - It downloads Node.js into `~/.flow-build` (checked against its checksum), installs Flow's libraries, builds
     `Flow.app` for this Mac, puts it in `/Applications` (or `~/Applications`), tidies up and opens Flow.
   - No admin password is needed. About 5 minutes. If you can run shell commands yourself, you may run this line.
   - macOS may ask "Terminal would like to access files in your Downloads folder": **Allow**.
   - It prints "Installing Flow <version>" first. It stops, changing nothing, if a newer Flow folder is beside
     this one (e.g. "Flow 2") or if the Flow already in Applications is some other app with the same name.
3. Install Claude Code (skip if `claude --version` already works): `curl -fsSL https://claude.ai/install.sh | bash`
   It goes to `~/.local/bin/claude`, which is where Flow looks (also Homebrew and `/usr/local/bin`).
4. The person signs in: `claude` in Terminal, sign in with their Claude account in the browser, then `/exit`.
5. Connect Flow (below).

macOS questions the first time (the person clicks):
- "Flow wants to use your confidential information stored in 'Flow Safe Storage'": Mac password, **Always Allow**.
- Touch ID when Flow opens: that's Flow's lock.
- "Flow wants to control Microsoft Word / Excel / PowerPoint / Messages": **OK**.
- "Flow would like to access data from other apps" or files in Downloads / Google Drive: **Allow**.
- For texts (iMessage): System Settings, Privacy & Security, **Full Disk Access**, **+**, pick Flow, switch it on,
  then quit Flow (the F in the menu bar, Quit) and open it again.

Updating later: move any old **Flow** folder in Downloads to the Bin first (otherwise the new zip unpacks as
"Flow 2" and the usual line would install the old version again), unzip the new zip into Downloads, and run the
same Terminal line. Settings and sign-ins are kept. If Flow can't read texts after an update although its Full Disk
Access switch looks on: in Full Disk Access select Flow, remove it with **-**, add it again with **+**, then quit
and reopen Flow.

## Windows

1. Run `Flow-Setup-<version>.exe`. It installs for this Windows account only (no admin).
2. "Windows protected your PC" (the app isn't code-signed): **More info**, then **Run anyway**.
3. Flow opens.
4. Install Claude Code (skip if `claude --version` already works), in PowerShell, no admin:
   `irm https://claude.ai/install.ps1 | iex`. It goes to `%USERPROFILE%\.local\bin\claude.exe`, which is where
   Flow looks. Git for Windows isn't needed.
5. The person signs in: open a new PowerShell window, `claude`, sign in in the browser, then `/exit`.
6. Connect Flow (below).

Updating later: from version 0.1.3, Flow updates itself (it installs when Flow quits, or from the tray's
**Restart to update**). Older copies: run the new installer James sends. Settings and sign-ins are kept.

## Connect Flow (both)

Flow opens on **Connections**. Go down the page:
1. **Database**: paste the database line, **Connect**. Flow sets up its own tables on first connect.
2. **Claude**: paste the key, **Save**. Flow checks the key works and the account has credit.
3. **Google**: **Load from file…**, pick the `.json` file, then **Connect Google**. The browser opens: sign in
   with the person's own Google account. "Google hasn't verified this app" is expected: **Advanced**, **Go to
   Flow**, allow everything listed.
4. **About you**: their full name (and first name if it isn't the first word) and a sentence about their work.
   Claude writes and signs off in this name. **Open Flow** stays off until a name is saved.
5. **Background work** (further down the same page): tick **Use Claude Code (my Claude subscription) for the mail
   check**, then **Save options**. It's off on a new copy on purpose, so Flow never uses a Claude account without
   the person choosing it.

Then **Open Flow**. Suggest **Practice mode** (same page) for the first day: everything is checked and confirmed but
nothing is sent. Flow's mail check runs every 5 minutes from 6am to 10pm; the **Sync** button works any time.

## Flow on their phone (optional)

Flow has a phone website at `https://flow-phone.pages.dev` (shared by everyone's Flow; it holds no data). Tasks and
drafts work any time; email, Claude and sending go through Flow on their computer, which must be on, awake and
online with Flow running. Nothing is sent unless the person taps Send on the phone; anything Flow's checks flag,
and every payment, asks them to confirm first.

It needs from James: a website login (email and password, made in the person's own database project, the password
typed by the person) and that project's **publishable** key (starts `sb_publishable_`; unlike the other keys this
one isn't secret, but never ask for or accept a key called *secret* or *service_role*).

1. In Flow: **Settings**, **Connections**, **Flow website**: paste the publishable key, **Save**.
2. **Connect a phone**: a QR code and a code show for 10 minutes.
3. On the phone: scan the QR code with the camera, open the link, sign in. A phone's first time has to be the QR
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
| Database won't connect, or "paused" | Check the line was pasted whole (starts `postgresql://`, no spaces). A free Supabase project pauses after 7 days unused: supabase.com/dashboard, the project, **Restore project**. Flow reconnects by itself. |
| Claude: key rejected / out of credit | Rejected: a typo or a deleted key, ask James. Out of credit: console.anthropic.com, Billing, add credit. Flow waits and carries on. |
| Google: "Access blocked" or an admin message | A work (Google Workspace) account whose admin blocks outside apps. Use a personal Gmail, or the admin allows Flow. |
| `claude: command not found` after installing Claude Code | Open a new Terminal / PowerShell window and try again. Flow itself finds it in `~/.local/bin` without the PATH. |
| Claude Code says the plan doesn't include it | They need Pro, Max or higher (not the free plan). Until then Flow's mail check uses the API key. |
| Claude Code signed out, or the plan's usage runs out | Nothing breaks: Flow uses the API key for that check and tries Claude Code again 30 minutes later. To sign back in: `claude`, then `/login`. |
| Red "Google disconnected: reconnect" by Sync | Click it and sign in to Google again. |
| **Open Flow** is greyed out | About you needs a full name, saved. |
| Phone: "Open Flow from your laptop first" | The phone (or its Home Screen copy) hasn't been given the laptop's link yet. Scan the QR code from **Connect a phone**, or paste the copied link in the box on that screen. |
| Phone: "Your laptop isn't answering" | The computer is asleep, off or offline, or Flow isn't running. Open the lid, plug it in, open Flow. Lists and drafts still work meanwhile. |
| Phone: "This phone isn't connected" | **Connect this phone** on the phone, then **Reconnect with Face ID**, or type a new code from **Connect a phone** on the computer. |
| Computer: "Paste your Supabase publishable key above and click Save first" | Step 1 above. The key comes from James. |
| Flow misbehaves later | F in the menu bar (Mac) or tray (Windows), **Open Flow's logs**, send James `flow.log` (and `flow.1.log`). Logs: Mac `~/Library/Application Support/Flow/logs`, Windows `%APPDATA%\Flow\logs`. |

Don't guess beyond this. If something isn't covered, the answer is: send James a screenshot.
