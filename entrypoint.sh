#!/bin/sh
set -eu

export HERMES_HOME="${HERMES_HOME:-/opt/data}"
MODEL="${HERMES_MODEL:-${HERMES_INFERENCE_MODEL:-kimi-k2.6}}"
BASE_URL="${OPENAI_BASE_URL:-https://tokendance.space/gateway/v1}"
API_MODE="${HERMES_API_MODE:-chat_completions}"

mkdir -p "$HERMES_HOME"
chmod 700 "$HERMES_HOME" 2>/dev/null || true

cat > "$HERMES_HOME/config.yaml" <<EOF
model:
  default: "$MODEL"
  provider: "custom"
  base_url: "$BASE_URL"
  api_key: "\${OPENAI_API_KEY}"
  api_mode: "$API_MODE"
custom_providers:
  - name: "tokendance"
    base_url: "$BASE_URL"
    api_key: "\${OPENAI_API_KEY}"
    model: "$MODEL"
    api_mode: "$API_MODE"
    discover_models: true
EOF

{
  printf 'OPENAI_BASE_URL=%s\n' "$BASE_URL"
  printf 'HERMES_INFERENCE_PROVIDER=custom\n'
  printf 'HERMES_INFERENCE_MODEL=%s\n' "$MODEL"
  printf 'HERMES_MODEL=%s\n' "$MODEL"
  printf 'HERMES_ACCEPT_HOOKS=%s\n' "${HERMES_ACCEPT_HOOKS:-1}"
  [ -n "${OPENAI_API_KEY:-}" ] && printf 'OPENAI_API_KEY=%s\n' "$OPENAI_API_KEY"
  [ -n "${API_SERVER_ENABLED:-}" ] && printf 'API_SERVER_ENABLED=%s\n' "$API_SERVER_ENABLED"
  [ -n "${API_SERVER_HOST:-}" ] && printf 'API_SERVER_HOST=%s\n' "$API_SERVER_HOST"
  [ -n "${API_SERVER_PORT:-}" ] && printf 'API_SERVER_PORT=%s\n' "$API_SERVER_PORT"
  [ -n "${API_SERVER_KEY:-}" ] && printf 'API_SERVER_KEY=%s\n' "$API_SERVER_KEY"
  [ -n "${API_SERVER_MODEL_NAME:-}" ] && printf 'API_SERVER_MODEL_NAME=%s\n' "$API_SERVER_MODEL_NAME"
  [ -n "${API_SERVER_CORS_ORIGINS:-}" ] && printf 'API_SERVER_CORS_ORIGINS=%s\n' "$API_SERVER_CORS_ORIGINS"
} > "$HERMES_HOME/.env"
chmod 600 "$HERMES_HOME/.env" 2>/dev/null || true
chown -R hermes:hermes "$HERMES_HOME" 2>/dev/null || true

exec /opt/hermes/bin/hermes gateway run --no-supervise
