### Build TorrServer web UI
FROM --platform=$BUILDPLATFORM node:16-alpine AS front

WORKDIR /app

ENV REACT_APP_SERVER_HOST="." \
    PUBLIC_URL=""

COPY src/web/package.json src/web/yarn.lock ./
RUN yarn install

COPY src/web ./
RUN yarn run build

### Build TorrServer
FROM --platform=$BUILDPLATFORM golang:1.27.1-alpine AS builder

COPY src /opt/src
COPY --from=front /app/build /opt/src/web/build

WORKDIR /opt/src

ARG TARGETARCH
ARG TORRSERVER_VERSION=MatriX.HA

ENV GOARCH=$TARGETARCH

RUN apk add --no-cache g++ \
    && go run gen_web.go \
    && cd server \
    && go mod tidy \
    && go clean -i -r -cache \
    && go build -ldflags "-s -w -checklinkname=0 -X server/version.Version=${TORRSERVER_VERSION}" -o /torrserver ./cmd

### Home Assistant runtime
FROM ghcr.io/home-assistant/base:latest

LABEL org.opencontainers.image.source="https://github.com/olegg-mir/HA-TorrServer" \
      org.opencontainers.image.title="HA-TorrServer" \
      org.opencontainers.image.description="TorrServer for Home Assistant with HA compatibility patches"

ENV TS_CONF_PATH="/opt/ts/config" \
    TS_LOG_PATH="/opt/ts/log" \
    TS_TORR_DIR="/opt/ts/torrents" \
    GODEBUG="madvdontneed=1"

RUN apk add --no-cache ffmpeg jq ca-certificates

COPY --from=builder /torrserver /usr/bin/torrserver
COPY run.sh /run.sh

RUN chmod a+x /run.sh

CMD ["/run.sh"]
