#!/usr/bin/env bash
# Fail if any of my own links in the README stops working (live demos, repos, Pages sites).
set -u
fail=0
for url in $(grep -oE 'https://(amanksingh633\.github\.io|github\.com/amanksingh633)[^) >"]*' README.md | sort -u); do
  code=$(curl -s -o /dev/null -w '%{http_code}' -L --max-time 20 "$url")
  if [ "$code" != "200" ]; then echo "BROKEN ($code): $url"; fail=1; else echo "ok: $url"; fi
done
exit $fail
