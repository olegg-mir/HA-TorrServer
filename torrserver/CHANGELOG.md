## 1.0.0-MatriX.145 - 2026-09-22

- Switched from the unmodified upstream container to an automatically built Home Assistant image based on TorrServer MatriX.145.
- Ported the Home Assistant compatibility changes from `aatrubilin/hassio-torrserver` as small patches instead of copied source files.
- Added `M3U_CUSTOM_HOST` support.
- Added Ingress-oriented search, playlist and poster URL fixes.
- Added Home Assistant Configuration options for HTTP authentication, Telegram, SSL, proxy, custom M3U host and web access logs.
- Added automatic multi-architecture GHCR builds for `amd64` and `arm64`.

