#!/bin/bash
set -e

PATCH_FILE="$(dirname "$0")/main.rs.patch"

if [ ! -f "$PATCH_FILE" ]; then
    echo "Error: patch file not found at $PATCH_FILE"
    exit 1
fi

git apply "$PATCH_FILE"
echo "Patch applied successfully"