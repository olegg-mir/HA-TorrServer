#!/usr/bin/with-contenv bashio
set -euo pipefail

TS_CONF_PATH="${TS_CONF_PATH:-/opt/ts/config}"
TS_LOG_PATH="${TS_LOG_PATH:-/opt/ts/log}"
TS_TORR_DIR="${TS_TORR_DIR:-/opt/ts/torrents}"

mkdir -p "$TS_CONF_PATH" "$TS_TORR_DIR"
touch "$TS_LOG_PATH"

PORT="$(bashio::config 'port')"
FLAGS=(
  --path "$TS_CONF_PATH"
  --logpath "$TS_LOG_PATH"
  --torrentsdir "$TS_TORR_DIR"
  --port "$PORT"
)

if [[ "$(bashio::config 'httpauth')" == "true" ]]; then
  bashio::log.info "HTTP authentication enabled"

  ACCESS_DB="${TS_CONF_PATH}/accs.db"
  printf '{}
' > "$ACCESS_DB"

  LOGIN_COUNT=0
  for key in $(bashio::config 'logins|keys'); do
    USERNAME="$(bashio::config "logins[${key}].username")"
    PASSWORD="$(bashio::config "logins[${key}].password")"

    tmp="$(mktemp)"
    jq --arg user "$USERNAME" --arg pass "$PASSWORD" '. + {($user): $pass}' "$ACCESS_DB" > "$tmp"
    mv "$tmp" "$ACCESS_DB"
    LOGIN_COUNT=$((LOGIN_COUNT + 1))
    bashio::log.info "HTTP authentication user added: $USERNAME"
  done

  if [[ "$LOGIN_COUNT" -eq 0 ]]; then
    bashio::log.error "HTTP authentication is enabled but no logins are configured"
    bashio::exit.nok
  fi

  FLAGS+=(--httpauth)
else
  bashio::log.info "HTTP authentication disabled"
fi

M3U_CUSTOM_HOST="$(bashio::config 'm3u_custom_host')"
if [[ -n "$M3U_CUSTOM_HOST" ]]; then
  export M3U_CUSTOM_HOST
  bashio::log.info "Custom M3U host enabled"
fi

TGTOKEN="$(bashio::config 'tgtoken')"
if [[ -n "$TGTOKEN" ]]; then
  FLAGS+=(--tg "$TGTOKEN")
  bashio::log.info "Telegram bot integration enabled"
fi

if [[ "$(bashio::config 'ssl')" == "true" ]]; then
  SSL_PORT="$(bashio::config 'ssl_port')"
  SSL_CERT="$(bashio::config 'ssl_cert')"
  SSL_KEY="$(bashio::config 'ssl_key')"

  FLAGS+=(--ssl --sslport "$SSL_PORT")

  SSL_PATH="${TS_CONF_PATH}/.ssl"
  mkdir -p "$SSL_PATH"

  if [[ -n "$SSL_CERT" ]]; then
    SSL_CERT_PATH="${SSL_PATH}/cert.pem"
    printf '%s
' "$SSL_CERT" > "$SSL_CERT_PATH"
    FLAGS+=(--sslcert "$SSL_CERT_PATH")
  fi

  if [[ -n "$SSL_KEY" ]]; then
    SSL_KEY_PATH="${SSL_PATH}/key.pem"
    printf '%s
' "$SSL_KEY" > "$SSL_KEY_PATH"
    FLAGS+=(--sslkey "$SSL_KEY_PATH")
  fi

  bashio::log.info "SSL enabled on port $SSL_PORT"
else
  bashio::log.info "SSL disabled"
fi

PROXY_MODE="$(bashio::config 'proxymode')"
if [[ "$PROXY_MODE" != "disabled" ]]; then
  PROXY_URL="$(bashio::config 'proxyurl')"

  if [[ -z "$PROXY_URL" ]]; then
    bashio::log.error "Proxy is enabled but proxyurl is empty"
    bashio::exit.nok
  fi

  FLAGS+=(--proxyurl "$PROXY_URL" --proxymode "$PROXY_MODE")
  bashio::log.info "Proxy enabled in $PROXY_MODE mode"
else
  bashio::log.info "Proxy disabled"
fi

if [[ "$(bashio::config 'weblog')" == "true" ]]; then
  FLAGS+=(--weblogpath /dev/stdout)
  bashio::log.info "Web access log enabled"
fi

bashio::log.info "Starting TorrServer on port $PORT"
exec torrserver "${FLAGS[@]}"
