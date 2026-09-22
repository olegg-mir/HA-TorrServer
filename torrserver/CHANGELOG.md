## 1.0.0-MatriX.145 - 2026-09-22

Based on upstream [TorrServer MatriX.145](https://github.com/YouROK/TorrServer/releases/tag/MatriX.145).

### Upstream release notes

### What's Changed
* feat(web): add one-click VLC action to single-file torrent cards by @SHAREN in https://github.com/YouROK/TorrServer/pull/815
* Add AppImage support for Linux amd64, arm64 and arm7 by @VuzzyM in https://github.com/YouROK/TorrServer/pull/838
* feat: manual categories for torznab by @DrachenClon22 in https://github.com/YouROK/TorrServer/pull/841
* Update Romanian translations by @VuzzyM in https://github.com/YouROK/TorrServer/pull/846
* Return a JSON body when /torrents rejects a request by @nfvelten in https://github.com/YouROK/TorrServer/pull/848
* feat(torznab): add Prowlarr indexer tracker support by @VuzzyM in https://github.com/YouROK/TorrServer/pull/850
* fix(web): SettingsDialog to support 'textarea' type input by @pavelpikta in https://github.com/YouROK/TorrServer/pull/849
* feat: add native MCP server for AI agents by @pavelpikta in https://github.com/YouROK/TorrServer/pull/840
* chore(Dockerfile): update Go version from 1.27.0 to 1.27.1 by @pavelpikta in https://github.com/YouROK/TorrServer/pull/855
* feat: update TrackersListURL handling by @pavelpikta in https://github.com/YouROK/TorrServer/pull/856
* chore(deps): update go-ffprobe dependency to v2.3.0 by @pavelpikta in https://github.com/YouROK/TorrServer/pull/857
* feat(waf): add HTTP access WAF with settings UI and API by @pavelpikta in https://github.com/YouROK/TorrServer/pull/847
* chore(deps): bump fast-uri from 3.1.5 to 3.1.7 in /web by @dependabot[bot] in https://github.com/YouROK/TorrServer/pull/853
* feat(server): add builds for iOS XCFramework by @pavelpikta in https://github.com/YouROK/TorrServer/pull/858
* chore(deps): bump js-yaml from 3.15.1 to 3.15.2 in /web by @dependabot[bot] in https://github.com/YouROK/TorrServer/pull/863
* mute LPD excessive logging by @tsynik
* feat: add MergeAllM3U setting to merge all torrent playlists into a single all.m3u by @VuzzyM in https://github.com/YouROK/TorrServer/pull/867
* fix (go-ffprobe):  parse Chapters by @tsynik
* fix (server): ffprobe binary path setup  by @tsynik
* feature (server): add json errors output to /stream and /ffp endpoints by @tsynik

### New Contributors
* @SHAREN made their first contribution in https://github.com/YouROK/TorrServer/pull/815
* @DrachenClon22 made their first contribution in https://github.com/YouROK/TorrServer/pull/841
* @nfvelten made their first contribution in https://github.com/YouROK/TorrServer/pull/848

**Full Changelog**: https://github.com/YouROK/TorrServer/compare/MatriX.144...MatriX.145

### Home Assistant packaging changes

- Switched from the unmodified upstream container to an automatically built Home Assistant image based on TorrServer MatriX.145.
- Ported the Home Assistant compatibility changes from `aatrubilin/hassio-torrserver` as small patches instead of copied source files.
- Added `M3U_CUSTOM_HOST` support.
- Added Ingress-oriented search, playlist and poster URL fixes.
- Added Home Assistant Configuration options for HTTP authentication, Telegram, SSL, proxy, custom M3U host and web access logs.
- Added automatic multi-architecture GHCR builds for `amd64` and `arm64`.

