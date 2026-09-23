#!/usr/bin/env bash
set -euo pipefail

PROFILE="proposal"
PORT=1810
FORMAT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) PROFILE="$2"; shift 2 ;;
    --port)    PORT="$2"; shift 2 ;;
    --render)  FORMAT="$2"; shift 2 ;;
    *)         echo "Unknown: $1"; exit 1 ;;
  esac
done

QUARTO_ARGS=(--profile "$PROFILE" --port "$PORT")
[[ -n "$FORMAT" ]] && QUARTO_ARGS+=(--to "$FORMAT")

cleanup() {
  echo ""
  echo "Stopping..."
  tailscale serve reset 2>/dev/null || true
  kill "$QUARTO_PID" 2>/dev/null || true
  wait "$QUARTO_PID" 2>/dev/null || true
  exit 0
}

trap cleanup SIGINT SIGTERM

quarto preview "${QUARTO_ARGS[@]}" &
QUARTO_PID=$!

sleep 3
tailscale serve --https="$PORT" "http://localhost:$PORT"

echo ""
echo "Preview:  http://localhost:$PORT"
echo "Tailnet:  https://$(tailscale ip -4):$PORT"
echo "Profile:  $PROFILE"
[[ -n "$FORMAT" ]] && echo "Format:   $FORMAT"
echo ""
echo "Press Ctrl+C to stop."

wait "$QUARTO_PID"
