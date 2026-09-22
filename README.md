# HA-TorrServer

A Home Assistant App repository for [YouROK/TorrServer](https://github.com/YouROK/TorrServer).

## About

HA-TorrServer packages the official TorrServer container for installation and automatic updates through Home Assistant.

The project is based on the original [YouROK/TorrServer](https://github.com/YouROK/TorrServer) project and was inspired by the Home Assistant packaging work in [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver).

The current implementation deliberately uses the **unmodified official upstream image**:

```text
ghcr.io/yourok/torrserver:<version>
```

This keeps TorrServer itself fully aligned with upstream releases and avoids maintaining a separate fork.

A GitHub Actions workflow checks the latest upstream release every 6 hours. It updates the Home Assistant app only after the matching upstream container image is available for both `amd64` and `arm64`.

## Relationship to hassio-torrserver

The existing [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver) project contains additional Home Assistant-specific work that is **not currently included** in HA-TorrServer:

- a custom `M3U_CUSTOM_HOST` override for generated M3U links;
- a small search URL adjustment for reverse-proxy/Ingress usage;
- playlist-opening behavior adapted for Home Assistant Ingress;
- forcing HTTP poster URLs to HTTPS to avoid mixed-content issues;
- a Home Assistant configuration wrapper for HTTP authentication, SSL, proxy settings, Telegram token, web access logs, and custom M3U host.

Those changes are useful reference work and are credited here accordingly. HA-TorrServer currently prioritizes staying on the official upstream image without source modifications. Any Home Assistant-specific fixes added later should be implemented as small, maintainable patches against the current upstream version rather than by carrying old copies of whole TorrServer source files.

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

## Credits

- [YouROK/TorrServer](https://github.com/YouROK/TorrServer) — original TorrServer project and official container images.
- [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver) — Home Assistant packaging, Ingress-related fixes, configuration wrapper, and other HA-specific implementation ideas.
