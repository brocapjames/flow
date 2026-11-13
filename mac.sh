#!/bin/bash
# Gets the newest Flow for a Mac and installs it: the one line on https://brocapjames.github.io/flow/join.html
#   curl -fsSL https://brocapjames.github.io/flow/mac.sh | bash -s -- <invite>
# The invite (the letters after the # in the link James sent) is optional: with it, Flow joins by itself the first
# time it opens. It is left in a small file beside Flow's settings, which Flow reads once and removes.
# It downloads Flow's Mac zip from Flow's own releases page, unzips it in ~/Downloads and runs the installer
# inside it (install-mac.sh), which builds Flow for this Mac and opens it. Nothing here needs your password.
set -euo pipefail

say() { printf '\n\033[1;34m%s\033[0m\n' "$*"; }
fail() { printf '\n\033[1;31m%s\033[0m\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = "Darwin" ] || fail "This is for a Mac. On Windows, use the download on the page instead."
REPO="https://github.com/brocapjames/flow-releases"

say "Finding the newest Flow…"
# The releases page's "latest" address forwards to the newest version's own page (…/releases/tag/v0.1.9).
LATEST="$(curl -fsSLI -o /dev/null -w '%{url_effective}' "$REPO/releases/latest")" || fail "Couldn't reach GitHub. Check the internet connection and paste the line again."
VERSION="${LATEST##*/tag/v}"
case "$VERSION" in
  ''|*[!0-9.]*) fail "Couldn't tell which Flow is the newest. Try again in a few minutes, or ask James." ;;
esac

WORK="$HOME/Downloads"
[ -d "$WORK" ] || WORK="$HOME"
ZIP="$WORK/Flow-for-Mac-$VERSION.zip"
DEST="$WORK/Flow"

say "Downloading Flow $VERSION…"
curl -fL --progress-bar "$REPO/releases/download/v$VERSION/Flow-for-Mac-$VERSION.zip" -o "$ZIP" || fail "Couldn't download Flow $VERSION. Check the internet connection and paste the line again."

# An older Flow folder from last time would make the unzip land beside it: it goes to the Bin's place first.
if [ -e "$DEST" ]; then
  [ -f "$DEST/install-mac.sh" ] || fail "There's already something called Flow in $WORK, and it isn't a Flow download. Move or rename it, then paste the line again."
  rm -rf "$DEST"
fi
/usr/bin/ditto -x -k "$ZIP" "$WORK" || fail "Couldn't unzip the download. Paste the line again."
rm -f "$ZIP"
[ -f "$DEST/install-mac.sh" ] || fail "The download didn't hold Flow's installer. Ask James."

# The invite, for Flow to pick up when it first opens (src/main/main.js, inviteWaiting). Letters, digits, - and _ only.
INVITE="${1:-}"
case "$INVITE" in
  '') ;;
  *[!A-Za-z0-9_-]*) say "That invite doesn't look right, so Flow will ask for it when it opens." ;;
  *) SETTINGS="$HOME/Library/Application Support/Flow"
     if mkdir -p "$SETTINGS" && printf 'flow-invite:%s\n' "$INVITE" > "$SETTINGS/invite.txt"; then chmod 600 "$SETTINGS/invite.txt" || true; fi ;;
esac

exec /bin/bash "$DEST/install-mac.sh"
