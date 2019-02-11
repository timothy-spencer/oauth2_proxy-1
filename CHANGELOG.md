# Vx.x.x (Pre-release)

## Changes since v3.1.0

- Added login.gov provider
- Added environment variables for all config options

# v3.1.0

## Release highlights

- Introduction of ARM releases and and general improvements to Docker builds
- Improvements to OIDC provider allowing pass-through of ID Tokens
- Multiple redirect domains can now be whitelisted
- Streamed responses are now flushed periodically

## Important notes

- If you have been using [#bitly/621](https://github.com/bitly/oauth2_proxy/pull/621)
  and have cookies larger than the 4kb limit,
  the cookie splitting pattern has changed and now uses `_` in place of `-` when
  indexing cookies.
  This will force users to reauthenticate the first time they use `v3.1.0`.
- Streamed responses will now be flushed every 1 second by default.
  Previously streamed responses were flushed only when the buffer was full.
  To retain the old behaviour set `--flush-interval=0`.
  See [#23](https://github.com/timothy-spencer/oauth2_proxy-1/pull/23) for further details.

## Changes since v3.0.0

- [#14](https://github.com/timothy-spencer/oauth2_proxy-1/pull/14) OIDC ID Token, Authorization Headers, Refreshing and Verification (@joelspeed)
  - Implement `pass-authorization-header` and `set-authorization-header` flags
  - Implement token refreshing in OIDC provider
  - Split cookies larger than 4k limit into multiple cookies
  - Implement token validation in OIDC provider
- [#15](https://github.com/timothy-spencer/oauth2_proxy-1/pull/15) WhitelistDomains (@joelspeed)
  - Add `--whitelist-domain` flag to allow redirection to approved domains after OAuth flow
- [#21](https://github.com/timothy-spencer/oauth2_proxy-1/pull/21) Docker Improvement (@yaegashi)
  - Move Docker base image from debian to alpine
  - Install ca-certificates in docker image
- [#23](https://github.com/timothy-spencer/oauth2_proxy-1/pull/23) Flushed streaming responses
  - Long-running upstream responses will get flushed every <timeperiod> (1 second by default)
- [#24](https://github.com/timothy-spencer/oauth2_proxy-1/pull/24) Redirect fix (@agentgonzo)
  - After a successful login, you will be redirected to your original URL rather than /
- [#35](https://github.com/timothy-spencer/oauth2_proxy-1/pull/35) arm and arm64 binary releases (@kskewes)
  - Add armv6 and arm64 to Makefile `release` target
- [#37](https://github.com/timothy-spencer/oauth2_proxy-1/pull/37) cross build arm and arm64 docker images (@kskewes)

# v3.0.0

Adoption of OAuth2_Proxy by Pusher.
Project was hard forked and tidied however no logical changes have occurred since
v2.2 as released by Bitly.

## Changes since v2.2:

- [#7](https://github.com/timothy-spencer/oauth2_proxy-1/pull/7) Migration to Pusher (@joelspeed)
  - Move automated build to debian base image
  - Add Makefile
    - Update CI to run `make test`
    - Update Dockerfile to use `make clean oauth2_proxy`
    - Update `VERSION` parameter to be set by `ldflags` from Git Status
    - Remove lint and test scripts
  - Remove Go v1.8.x from Travis CI testing
  - Add CODEOWNERS file
  - Add CONTRIBUTING guide
  - Add Issue and Pull Request templates
  - Add Dockerfile
  - Fix fsnotify import
  - Update README to reflect new repository ownership
  - Update CI scripts to separate linting and testing
    - Now using `gometalinter` for linting
  - Move Go import path from `github.com/bitly/oauth2_proxy` to `github.com/timothy-spencer/oauth2_proxy-1`
  - Repository forked on 27/11/18
    - README updated to include note that this repository is forked
    - CHANGLOG created to track changes to repository from original fork
