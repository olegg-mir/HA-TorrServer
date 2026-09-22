# Home Assistant compatibility patches

These patches are intentionally small and are applied on top of the exact upstream TorrServer release selected by CI.

They are adapted from Home Assistant-specific changes maintained in [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver).

- `0001-m3u-custom-host.patch` — allows generated M3U links to use the `M3U_CUSTOM_HOST` environment variable.
- `0002-ingress-search-trailing-slash.patch` — preserves the URL behavior required by the existing HA Ingress package.
- `0003-ingress-playlist-self-target.patch` — keeps playlist navigation inside the current Ingress context.
- `0004-ingress-poster-https.patch` — avoids mixed-content errors by upgrading HTTP poster URLs to HTTPS.

The workflow runs `git apply --check` before applying every patch. If upstream changes make any patch unsafe to apply, the update fails and the previous working Home Assistant version remains published.
