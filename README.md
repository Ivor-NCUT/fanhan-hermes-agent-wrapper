# Hermes Agent Wrapper

This wrapper keeps the official `nousresearch/hermes-agent` image intact and only changes the container command so InsForge image mode can run the Hermes gateway API.

At startup it writes a minimal Hermes config from environment variables so the API server can use Tokendance as an OpenAI-compatible custom provider without an interactive setup step.

The image expects runtime environment variables to be injected by the deployment platform:

- `API_SERVER_ENABLED=true`
- `API_SERVER_HOST=0.0.0.0`
- `API_SERVER_PORT=8642`
- `API_SERVER_KEY`
- `OPENAI_API_KEY`
- `OPENAI_BASE_URL=https://tokendance.space/gateway/v1`
- `HERMES_INFERENCE_PROVIDER=custom`
- `HERMES_TUI_PROVIDER=custom`
- `HERMES_INFERENCE_MODEL=kimi-k2.6`
- `HERMES_MODEL=kimi-k2.6`
- `HERMES_HEADLESS=1`
