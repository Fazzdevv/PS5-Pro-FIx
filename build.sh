#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

SDK_DIR="$DIR/sdk/ps5-payload-sdk"

echo "=== Mengompilasi PS5 Pro-Fix Standalone Payload dengan Official ps5-payload-sdk ==="
"$SDK_DIR/bin/prospero-clang" -Wall -O2 \
    -o pro_fix.elf \
    pro_fix.c

echo ""
echo "=== Selesai! Detail pro_fix.elf: ==="
ls -lh pro_fix.elf
readelf -l pro_fix.elf
readelf -d pro_fix.elf
