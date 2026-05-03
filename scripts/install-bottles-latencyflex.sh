#!/usr/bin/env bash
set -Eeuo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LATENCYFLEX_ONLY="${LATENCYFLEX_ONLY:-0}" exec "$REPO_DIR/scripts/install-bottles-full-setup.sh" "$@"
