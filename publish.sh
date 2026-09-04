#!/bin/bash
# Publish a demo folder to GitHub Pages. Usage: ./publish.sh <slug>
# The folder must already exist at ./<slug>/index.html
set -e
S="${1:?usage: ./publish.sh <slug>}"
D="/Users/hamza/HAMZA WORK/demos"
[ -f "$D/$S/index.html" ] || { echo "MISSING: $D/$S/index.html"; exit 1; }
cd "$D"
git add -A && git commit -q -m "demo: $S" && git push -q
echo "LIVE (allow ~60s): https://hamzachaudhary94.github.io/demos/$S/"
