## 1.0.0-MatriX.146 - 2026-10-09

Based on upstream [TorrServer MatriX.146](https://github.com/YouROK/TorrServer/releases/tag/MatriX.146).

### Upstream release notes

### What's Changed
* feat(ssl): manage the HTTPS certificate from the web UI without a restart by @lieranderl in https://github.com/YouROK/TorrServer/pull/899
* perf: buffer HTTP stream reads to reduce client-lock contention by @vladikshkwok in https://github.com/YouROK/TorrServer/pull/900

### New Contributors
* @vladikshkwok made their first contribution in https://github.com/YouROK/TorrServer/pull/900

**Full Changelog**: https://github.com/YouROK/TorrServer/compare/MatriX.145.2...MatriX.146


## 1.0.0-MatriX.145.2 - 2026-10-06

Based on upstream [TorrServer MatriX.145.2](https://github.com/YouROK/TorrServer/releases/tag/MatriX.145.2).

### Upstream release notes

### What's Changed
* fix(ssl): never replace user-supplied certs, tighten generated key perms by @lieranderl in https://github.com/YouROK/TorrServer/pull/884
* fix: find Entware root CA certificates for outgoing HTTPS by @lieranderl in https://github.com/YouROK/TorrServer/pull/890
* test(rutor): skip parse tests when rutor.ls is missing by @lieranderl in https://github.com/YouROK/TorrServer/pull/893
* test(trackers): fix data race in refresh tests by @lieranderl in https://github.com/YouROK/TorrServer/pull/894
* feat(ssl): cert hot reload, managed servers, strict --force-https, --http-media, --https-only by @lieranderl in https://github.com/YouROK/TorrServer/pull/885
* fix(torr): stop the nil dereference when settings reconnect the client by @ManSio in https://github.com/YouROK/TorrServer/pull/896

### New Contributors
* @ManSio made their first contribution in https://github.com/YouROK/TorrServer/pull/896

**Full Changelog**: https://github.com/YouROK/TorrServer/compare/MatriX.145.1...MatriX.145.2


## 1.0.0-MatriX.145.1 - 2026-10-01

Based on upstream [TorrServer MatriX.145.1](https://github.com/YouROK/TorrServer/releases/tag/MatriX.145.1).

### Upstream release notes

### What's Changed
* fix: send a User-Agent when checking poster images by @uPagge in https://github.com/YouROK/TorrServer/pull/882
* fix: retry BT client connect after settings save by @uPagge in https://github.com/YouROK/TorrServer/pull/883
* fix(macos): plist file update process by @pavelpikta in https://github.com/YouROK/TorrServer/pull/874
* refactor: image URL validation by @pavelpikta in https://github.com/YouROK/TorrServer/pull/871
* gstreamer: re-encode AAC profiles browsers cannot play (Main, SSR, LTP) by @lieranderl in https://github.com/YouROK/TorrServer/pull/879
* fix(torrstor): evict partially downloaded pieces last by @LuckyRu in https://github.com/YouROK/TorrServer/pull/875
* fix(torrstor): never park a reader while a read is in flight by @LuckyRu in https://github.com/YouROK/TorrServer/pull/876

### New Contributors
* @uPagge made their first contribution in https://github.com/YouROK/TorrServer/pull/882
* @LuckyRu made their first contribution in https://github.com/YouROK/TorrServer/pull/875

**Full Changelog**: https://github.com/YouROK/TorrServer/compare/MatriX.145...MatriX.145.1


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

