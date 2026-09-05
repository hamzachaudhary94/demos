#!/bin/bash
# Publish a demo folder to GitHub Pages. Usage: ./publish.sh <slug>
#
# 🩸 5 Sep 2026, MotionOx Control Hub. THIS SCRIPT ANNOUNCED A LIE.
# It ran:   git add -A && git commit -q -m "..." && git push -q
# then echoed LIVE unconditionally. When the auto-backup hook had already committed the
# file, `git commit` exited non-zero with "nothing to commit", the `&&` chain stopped, the
# PUSH NEVER RAN, and the script still printed LIVE. `set -e` does not catch a failure
# inside an && list, so nothing stopped it.
#
# The page happened to be live that time because the hook had also pushed. Next time it
# would not be, and the caller would have been told it was.
#
# 🛑 THE FIX IS NOT A BETTER MESSAGE. It is that "live" is now MEASURED, not assumed:
# nothing-to-commit is treated as a normal case, the push always runs, and the URL is
# fetched before the word LIVE is printed.
set -uo pipefail
S="${1:?usage: ./publish.sh <slug>}"
D="/Users/hamza/HAMZA WORK/demos"
[ -f "$D/$S/index.html" ] || { echo "MISSING: $D/$S/index.html"; exit 1; }
cd "$D" || exit 1

git add -A
if git diff --cached --quiet; then
  echo "nothing new to commit, the file was already staged and committed (usually the auto-backup hook)"
else
  git commit -q -m "demo: $S" || { echo "🛑 COMMIT FAILED. Nothing published."; exit 1; }
fi

# ALWAYS push. The old chain skipped this whenever the commit was a no-op, which is the
# exact case the auto-backup hook creates several times an hour.
if ! git push -q; then
  echo "🛑 PUSH FAILED. Nothing is live. Fix the remote and run this again."
  exit 1
fi

URL="https://hamzachaudhary94.github.io/demos/$S/"
# 🛑 MEASURE IT. GitHub Pages takes a moment, so poll rather than guess.
for i in 1 2 3 4 5 6 7 8 9 10; do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$URL")
  [ "$CODE" = "200" ] && { echo "LIVE, verified HTTP 200: $URL"; exit 0; }
  sleep 6
done
echo "🛑 PUSHED, but $URL still answers HTTP $CODE after ~60s."
echo "   It may just be slow. Re-check before telling anyone it is live."
exit 2
