# TorrServer Home Assistant App

## Usage

After installing and starting the app, open it from Home Assistant or connect directly to:

```text
http://<home-assistant-ip>:8090
```

The app runs the official `ghcr.io/yourok/torrserver` image.

## Persistent storage

Home Assistant `addon_config` storage is mounted at `/opt/ts` inside the container. This matches the official TorrServer Docker image defaults:

- `/opt/ts/config` - configuration and database
- `/opt/ts/log` - logs
- `/opt/ts/torrents` - torrent metadata/files used by TorrServer

## Updates

This repository tracks the latest non-draft, non-prerelease GitHub release from `YouROK/TorrServer`. A scheduled workflow verifies the matching official container image supports both `amd64` and `arm64` before publishing the new Home Assistant app version.

## Ingress

Ingress is enabled on port `8090`. TorrServer itself is not modified for Home Assistant, so features that generate absolute links may work better through direct LAN access if an Ingress-specific edge case is encountered.
