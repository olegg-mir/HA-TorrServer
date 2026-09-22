# TorrServer Home Assistant App

This app builds the current upstream [TorrServer](https://github.com/YouROK/TorrServer) release with a small set of Home Assistant compatibility patches adapted from [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver).

## Access

With the default settings, TorrServer listens on:

```text
http://<home-assistant-ip>:8090
```

Home Assistant Ingress is enabled on the same port.

> Keep the HTTP port at `8090` if you want to use the built-in Ingress entry. A custom port is supported for direct network access, but Home Assistant's static `ingress_port` cannot follow that option.

## Configuration

The Configuration tab provides:

- HTTP authentication and user/password pairs;
- Telegram bot token;
- custom M3U host;
- TorrServer SSL and SSL port;
- optional PEM certificate/private key;
- BitTorrent proxy mode and proxy URL;
- web access logging.

## Persistent storage

The app-specific Home Assistant configuration directory is mounted at `/opt/ts`.

TorrServer uses:

- `/opt/ts/config` — database and configuration;
- `/opt/ts/torrents` — torrent metadata/files;
- `/opt/ts/log` — TorrServer log.

## Automatic updates

This repository checks upstream TorrServer releases every 6 hours. A new Home Assistant version is published only after all compatibility patches still apply and the multi-architecture image builds successfully.
