# AGENTS.md

## Purpose

This repository packages [YouROK/TorrServer](https://github.com/YouROK/TorrServer) as a Home Assistant App and keeps it synchronized with upstream TorrServer releases.

It is intentionally **not** a long-lived source fork of TorrServer. The expected maintenance model is:

1. check out an exact upstream TorrServer release tag;
2. apply a small Home Assistant-specific patch set;
3. build and publish a multi-architecture Home Assistant image;
4. verify the published image;
5. only then update Home Assistant metadata and publish a GitHub Release.

Home Assistant-specific ideas and the original compatibility work were adapted from [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver).

## Repository layout

```text
.
├── AGENTS.md
├── LICENSE
├── README.md
├── repository.yaml
├── .github/
│   └── workflows/
│       └── update-torrserver.yml
└── torrserver/
    ├── CHANGELOG.md
    ├── DOCS.md
    ├── Dockerfile
    ├── README.md
    ├── config.yaml
    ├── icon.png
    ├── logo.png
    ├── package-version.txt
    ├── run.sh
    ├── patches/
    │   ├── 0001-m3u-custom-host.patch
    │   ├── 0002-ingress-search-trailing-slash.patch
    │   ├── 0003-ingress-playlist-self-target.patch
    │   ├── 0004-ingress-poster-https.patch
    │   └── README.md
    └── translations/
        ├── en.yaml
        └── ru.yaml
```

## Core design

### Upstream source

The build workflow fetches the latest non-prerelease GitHub Release from `YouROK/TorrServer` and checks out that exact release tag into `torrserver/src` during CI.

Do not vendor or commit the complete upstream TorrServer source tree into this repository.

### Home Assistant patches

The HA-specific source changes live under `torrserver/patches/`.

Current patches provide:

- `0001-m3u-custom-host.patch`: `M3U_CUSTOM_HOST` support for generated M3U links.
- `0002-ingress-search-trailing-slash.patch`: search URL behavior used behind Home Assistant Ingress/reverse proxy.
- `0003-ingress-playlist-self-target.patch`: opens playlists in the current Ingress context.
- `0004-ingress-poster-https.patch`: upgrades HTTP poster URLs to HTTPS to avoid mixed-content failures.

The workflow must run `git apply --check` before applying patches. A patch conflict is a safety stop, not something to bypass automatically.

When upstream code changes:

1. inspect the new upstream implementation first;
2. determine whether the old workaround is still necessary;
3. update the smallest possible patch hunk;
4. never replace a whole upstream file with an older copied version just to make the patch apply;
5. keep the patch description in `torrserver/patches/README.md` accurate.

If a workaround becomes unnecessary because upstream fixed the problem, remove the patch instead of preserving obsolete behavior.

## Home Assistant wrapper

`torrserver/run.sh` translates Home Assistant App configuration into current TorrServer command-line arguments.

Current supported configuration includes:

- HTTP port;
- HTTP authentication and user/password pairs;
- Telegram bot token;
- custom M3U host;
- SSL, SSL port, certificate and private key;
- BitTorrent proxy mode and proxy URL;
- web access logging.

When adding an option:

1. verify the current argument name in the upstream TorrServer release;
2. add it to both `options` and `schema` in `torrserver/config.yaml`;
3. add English and Russian labels in `torrserver/translations/`;
4. map it in `torrserver/run.sh`;
5. update `torrserver/DOCS.md`.

Do not assume old argument names from `hassio-torrserver` are still valid. For example, current TorrServer uses `--tg` for the Telegram token.

## Persistent data

Home Assistant `addon_config` storage is mounted at `/opt/ts`.

The expected TorrServer paths are:

- `/opt/ts/config`
- `/opt/ts/torrents`
- `/opt/ts/log`

Preserve these paths unless there is a deliberate migration plan. Changing them can make existing Home Assistant installations appear to lose configuration or torrent state.

## Networking and Ingress

The App currently uses:

- host networking;
- TorrServer HTTP port `8090` by default;
- Home Assistant Ingress on static port `8090`;
- watchdog endpoint `/echo`.

The HTTP port is exposed as a user option, but Home Assistant's `ingress_port` is static. If the user changes TorrServer away from `8090`, direct LAN access can still work while the built-in Ingress entry will no longer point at the configured port.

Do not claim that a custom HTTP port is dynamically reflected in Ingress unless the Home Assistant packaging is changed to make that true.

## Docker build

`torrserver/Dockerfile`:

1. builds the TorrServer web UI;
2. builds the Go server from the checked-out and patched upstream source;
3. creates the Home Assistant runtime image;
4. includes `ffmpeg`, `jq`, and CA certificates.

Supported published architectures are:

- `linux/amd64`
- `linux/arm64`

Avoid putting secrets in Docker `ARG` or `ENV`. The project deliberately removed the unused `REACT_APP_TMDB_API_KEY` build argument after BuildKit correctly warned about secret-like variable names.

## Versioning

`torrserver/package-version.txt` stores the Home Assistant packaging version.

The published App/image/release version is:

```text
<package-version>-<upstream-tag>
```

Example:

```text
1.0.0-MatriX.145
```

The upstream part changes when TorrServer releases a new version. Increment the packaging version when the Home Assistant packaging itself requires a release distinction that cannot be represented only by a new upstream tag.

Keep these aligned:

- `torrserver/config.yaml -> version`
- GHCR image tag
- GitHub Release tag/title

## CI/CD workflow

The primary workflow is `.github/workflows/update-torrserver.yml`.

It runs:

- every 6 hours;
- manually via `workflow_dispatch`;
- on changes to build/wrapper/patch/workflow files.

Expected order:

1. resolve latest upstream release;
2. log in to GHCR;
3. determine whether an image needs to be built;
4. check out the upstream release;
5. validate and apply all HA patches;
6. configure QEMU/Buildx;
7. build and push `amd64` + `arm64`;
8. inspect the published manifest and require both architectures;
9. update HA metadata/changelog when needed;
10. create/update the corresponding GitHub Release behavior idempotently;
11. write a readable GitHub Actions summary.

### Safety invariant

Never update `torrserver/config.yaml` to advertise a version before the corresponding GHCR image has been successfully published and verified for both supported architectures.

If build, patch validation, or image verification fails, the currently advertised Home Assistant version must remain unchanged.

## Releases and packages

Container images are published to:

```text
ghcr.io/olegg-mir/ha-torrserver:<version>
```

GitHub Releases are created for successful versions. The workflow mirrors the upstream `YouROK/TorrServer` GitHub Release notes into both `torrserver/CHANGELOG.md` and the HA-TorrServer GitHub Release description.

Release handling must be idempotent: re-running the workflow for an existing version should refresh its title/description rather than fail or create a duplicate. This also allows corrected upstream release notes to be synchronized on a later run.

The GitHub Release does not need binary assets; the deployable artifact for Home Assistant is the GHCR image.

## Images and branding

The Home Assistant assets are official TorrServer artwork copied from upstream:

- `torrserver/icon.png`
- `torrserver/logo.png`

Do not replace them with unrelated artwork without an explicit project decision. The root README references `torrserver/logo.png` so the repository page displays the TorrServer branding.

## Validation checklist

Before considering a packaging change complete, verify as applicable:

- YAML remains valid.
- All patch files pass `git apply --check` against the selected upstream tag.
- TorrServer compiles after patches are applied.
- The Docker build succeeds for both `amd64` and `arm64`.
- The GHCR manifest contains both architectures.
- Home Assistant can install/start the App.
- Ingress opens successfully on the default port.
- Direct access to port `8090` works on the LAN when expected.
- Persistent configuration survives an App update.
- GitHub Release creation succeeds or reports that the release already exists.
- No credentials or tokens are committed.

## Diagnosing workflow failures

Use the first failed workflow step, not only the top-level exit code.

Common cases:

### Patch failure

Look at `Verify and apply Home Assistant patches`.

Examples:

```text
error: corrupt patch ...
error: patch failed ...
patch does not apply cleanly ...
```

A corrupt patch usually means the unified diff hunk counts/content are malformed. A cleanly formatted patch that no longer applies usually means upstream changed the surrounding code and the patch must be rebased conceptually.

### Docker build failure

Open `Build and publish Home Assistant image` and locate the first real `ERROR` above the final Buildx failure.

### Image verification failure

Open `Verify target multi-arch image`. Both `amd64` and `arm64` must be present in the manifest.

### Release failure

Open `Publish GitHub Release`. The workflow uses the repository `GITHUB_TOKEN`; no personal access token should be required.

## Attribution and license

This repository must continue to credit:

- [YouROK/TorrServer](https://github.com/YouROK/TorrServer) for TorrServer itself.
- [aatrubilin/hassio-torrserver](https://github.com/aatrubilin/hassio-torrserver) for the Home Assistant packaging and compatibility ideas adapted here.

TorrServer is GPL-3.0, and this repository includes a copy of the GPL-3.0 license. Preserve applicable license notices when modifying or redistributing derived code.

## Guidance for future agents

Before making changes:

1. read this file;
2. read `README.md`;
3. inspect `torrserver/config.yaml`, `torrserver/run.sh`, and the current workflow;
4. inspect the latest upstream TorrServer code for any feature you intend to patch;
5. inspect `aatrubilin/hassio-torrserver` only as historical/reference implementation, not as authoritative current TorrServer code.

Prefer small, auditable changes. Preserve upstream functionality. Do not solve patch conflicts by pinning the project indefinitely to an old TorrServer release unless explicitly requested.
