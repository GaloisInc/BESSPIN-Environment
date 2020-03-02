#!/bin/bash
set -e

ERROR_COUNT=0
err() {
    echo error: "$@"
    ERROR_COUNT=$((ERROR_COUNT + 1))
}

TESTING="$(dirname "$0")"

for f in test-outputs/*; do
    base="$(basename "$f")"
    ref="tutorial/example-outputs/$base"
    if [[ ! -f "$ref" ]]; then
        echo "skipping: $f (no reference output for comparison)"
        continue
    fi

    case "$base" in
        *.pdf)
            python3 "$TESTING/compare_image.py" "$ref" "$f" 0.05
            ;;
        *.fm.json|*-fm.json)
            python3 "$TESTING/compare_fmjson.py" "$ref" "$f"
            ;;
        *)
            err "failed: $f (unknown file extension)"
            continue
            ;;
    esac
    echo "matched: $f"
done

for f in tutorial/example-outputs/*; do
    base="$(basename "$f")"
    if [[ ! -f "test-outputs/$base" ]]; then
        err "missing output: $base"
    fi
done

if [[ "$ERROR_COUNT" -eq 0 ]]; then
    echo "all outputs match"
    exit 0
else
    echo "found $ERROR_COUNT errors"
    exit 1
fi
