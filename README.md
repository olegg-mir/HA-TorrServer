# HA-TorrServer

A Home Assistant App repository for [YouROK/TorrServer](https://github.com/YouROK/TorrServer).

This repository does **not** rebuild or fork TorrServer. The Home Assistant app uses the official multi-architecture image published by the upstream project:

```text
ghcr.io/yourok/torrserver:<version>
```

A GitHub Actions workflow checks the latest upstream release every 6 hours. It updates the Home Assistant app only after the matching upstream container image is available for both `amd64` and `arm64`.

## Installation

Add this repository to the Home Assistant App Store:

```text
https://github.com/olegg-mir/HA-TorrServer
```

Then install **TorrServer** from the repository.

## Updating

Updates are automatic at repository level:

1. The workflow checks `YouROK/TorrServer` for the latest release.
2. It verifies the matching `ghcr.io/yourok/torrserver:<tag>` multi-arch image exists.
3. It changes `torrserver/config.yaml` to that tag.
4. Home Assistant then detects the new app version and offers the normal Update action.

## Persistent data

The Home Assistant app maps its `addon_config` storage to `/opt/ts`, matching the official TorrServer image layout. TorrServer configuration, logs and torrent metadata therefore remain persistent across app upgrades.

## Networking

The app uses host networking, matching the behavior of the existing community Home Assistant package and allowing TorrServer to use the host network directly. The TorrServer HTTP service listens on port `8090` by default.

Home Assistant Ingress is enabled on port `8090`. Some upstream web features that create absolute URLs may behave differently behind Ingress; direct access at `http://<home-assistant-ip>:8090` remains available on the local network.

## Upstream

TorrServer is developed by [YouROK](https://github.com/YouROK/TorrServer). This repository only provides Home Assistant packaging metadata and automatic version tracking.
