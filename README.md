# HA-TorrServer

A Home Assistant App for [YouROK/TorrServer](https://github.com/YouROK/TorrServer), with automatic upstream updates and Home Assistant-specific compatibility patches.

## About

HA-TorrServer builds the current TorrServer release for Home Assistant and keeps it synchronized with upstream automatically.

The project is based on the original [YouROK/TorrServer](https://github.com/YouROK/TorrServer) and incorporates Home Assistant-specific work inspired by [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver).

Unlike a long-lived source fork, this repository downloads the current upstream release, applies a small and explicit patch set, and builds a Home Assistant image. If an upstream change makes a patch no longer applicable, the build fails instead of silently replacing new TorrServer code with an old copied file.

## Home Assistant-specific changes

The following compatibility changes from `aatrubilin/hassio-torrserver` are carried forward and adapted to the current upstream code:

- `M3U_CUSTOM_HOST` support for generated M3U links;
- search URL trailing-slash handling for reverse proxy / Ingress use;
- opening generated playlists in the current Ingress context instead of a new tab;
- converting HTTP poster URLs to HTTPS to avoid mixed-content problems;
- Home Assistant Configuration UI for HTTP authentication, Telegram token, M3U custom host, SSL, proxy settings and web access logs.

The patches live in `torrserver/patches/` and are applied to the selected TorrServer release during CI.

## Automatic updates

Every 6 hours GitHub Actions checks the latest non-prerelease release from `YouROK/TorrServer`.

When a new upstream release appears, the workflow:

1. checks out the exact upstream release tag;
2. verifies and applies the HA patch set;
3. builds a multi-architecture image for `amd64` and `arm64`;
4. publishes it as `ghcr.io/olegg-mir/ha-torrserver:<app-version>-<upstream-tag>`;
5. updates `torrserver/config.yaml` and the changelog only after the image build succeeds.

This means an upstream change that conflicts with an HA patch will stop the update rather than publish a potentially broken package.

## Installation

Add this repository to the Home Assistant App Store:

```text
https://github.com/olegg-mir/HA-TorrServer
```

Then install **TorrServer**.

## Persistent data

The Home Assistant app maps its `addon_config` storage to `/opt/ts`, matching the official TorrServer Docker layout:

- `/opt/ts/config`
- `/opt/ts/torrents`
- `/opt/ts/log`

This keeps TorrServer data persistent across app upgrades.

## Networking and Ingress

TorrServer uses host networking and listens on port `8090` by default. Home Assistant Ingress also points to port `8090`.

The HTTP port is configurable for compatibility with the previous Home Assistant package, but changing it from `8090` will make the built-in Ingress entry stop working. Direct LAN access can use the configured port.

## Credits

- [YouROK/TorrServer](https://github.com/YouROK/TorrServer) — original TorrServer project.
- [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver) — Home Assistant packaging, Ingress-related fixes and configuration ideas that this project adapts for current TorrServer releases.
