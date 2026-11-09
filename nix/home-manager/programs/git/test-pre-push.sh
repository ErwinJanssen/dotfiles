#!/bin/sh
# Tests for the pre-push hook (./pre-push).
#
# Creates a throwaway GPG key and a temporary repository with a local bare
# remote, then pushes various commit shapes and checks that the hook blocks
# exactly the unsigned commits authored by the configured user.
#
# Usage: nix/home-manager/programs/git/test-pre-push.sh

set -eu

hook_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

export GNUPGHOME="$tmp/gnupg"
mkdir -p "$GNUPGHOME"
chmod 700 "$GNUPGHOME"

gpg --batch --pinentry-mode loopback --passphrase '' \
    --quick-generate-key 'Hook Test <hook-test@example.com>' ed25519 sign never
key_fp=$(gpg --batch --with-colons --list-keys 'hook-test@example.com' | awk -F: '$1 == "fpr" { print $10; exit }')

repo="$tmp/repo"
remote="$tmp/remote.git"
git init -q -b main "$repo"
git init -q --bare "$remote"

git -C "$repo" config user.name 'Hook Test'
git -C "$repo" config user.email 'hook-test@example.com'
git -C "$repo" config signing.key "$key_fp"
git -C "$repo" config commit.gpgSign true
git -C "$repo" config core.hooksPath "$hook_dir"
git -C "$repo" remote add origin "$remote"

failures=0

# expect_push <ok|fail> <description> <push args...>
expect_push() {
    expected=$1
    desc=$2
    shift 2
    if git -C "$repo" push "$@" >"$tmp/out" 2>&1; then
        result=ok
    else
        result=fail
    fi
    if [ "$result" = "$expected" ]; then
        echo "ok   - $desc"
    else
        echo "FAIL - $desc (expected $expected, got $result)"
        sed 's/^/       /' "$tmp/out"
        failures=$((failures + 1))
    fi
}

# 1. A signed commit by the configured user pushes fine.
git -C "$repo" commit -q --allow-empty -m 'signed commit'
expect_push ok 'signed commit by configured user is pushed' origin main

# 2. An unsigned commit by the configured user is blocked, and the commit
#    is listed in the error message.
git -C "$repo" commit -q --allow-empty --no-gpg-sign -m 'unsigned own commit'
if git -C "$repo" push origin main >"$tmp/out" 2>&1; then
    echo 'FAIL - unsigned own commit should be blocked'
    failures=$((failures + 1))
elif grep -q 'refusing to push' "$tmp/out" && grep -q 'unsigned own commit' "$tmp/out"; then
    echo 'ok   - unsigned own commit is blocked and listed'
else
    echo 'FAIL - push blocked but error message is missing'
    sed 's/^/       /' "$tmp/out"
    failures=$((failures + 1))
fi
git -C "$repo" reset -q --hard HEAD~1

# 3. An unsigned commit by a different author is allowed: only commits
#    authored by the configured user are checked.
git -C "$repo" -c user.name=Other -c user.email=other@example.com \
    commit -q --allow-empty --no-gpg-sign -m 'unsigned foreign commit'
expect_push ok 'unsigned commit by another author is allowed' origin main

# 4. On a new branch the hook checks the commits that are not on any remote
#    yet: the unsigned commit is blocked, and passes once it is signed.
git -C "$repo" switch -q -c feature
git -C "$repo" commit -q --allow-empty --no-gpg-sign -m 'unsigned feature commit'
expect_push fail 'unsigned commit on a new branch is blocked' origin feature
git -C "$repo" commit -q --amend --no-edit --allow-empty -S
expect_push ok 'the same commit is pushed after signing it' origin feature

# 5. Deleting a remote ref is allowed.
expect_push ok 'deleting a remote ref is allowed' origin :feature

if [ "$failures" -gt 0 ]; then
    echo "$failures test(s) failed"
    exit 1
fi
echo 'all tests passed'
