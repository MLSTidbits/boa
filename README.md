<div align="left">
 <image
    src="images/logo.svg"
    alt="HealthGPT Logo"
    width=100%
    height=auto
  />
</div>

## Brief Introduction

**BOA** is a small wrapper for building a Debian/Ubuntu DEB package. It is designed to be simple and easy to use, allowing users to create DEB packages with minimal effort. BOA is particularly useful for developers who want to distribute their software in a Debian/Ubuntu environment.

## Features

- Simple and easy to use
- YAML configuration for easier readability
- Supports multiple architectures (amd64, arm64, etc.)
- Auto semantic versioning VIA git logs
- Generates Debian changelog
- Define package signing using GPG

## Installation

The best way to install **BOA** is to add the [repository](https://archive.mlstidbits.com/) to your system's package manager and install it using `apt`.

```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/MLSTidbits.gpg] https://archive.mlstidbits.com/ stable main" | sudo tee /etc/apt/sources.list.d/MLSTidbits.list

wget -qO - https://archive.mlstidbits.com/key/MLSTidbits.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/MLSTidbits.gpg
```

Then update your package list and install with `sudo apt update && sudo apt install boa --yes`

## Usage

To use **BOA**, create a `boa.yaml` configuration file in the root of your project. Here is an example configuration:

- `format`: The format of the package. Currently, only `yaml` is supported.
- `application`: The name of the application/package.
- `build`: The type of build to perform. Options are `binary`, `source`, or `binary,source`.
- `no_pre_clean`: If set to `true`, skips the pre-clean step before building.
- `no_post_clean`: If set to `true`, skips the post-clean step after building.
- `check_builddeps`: If set to `true`, checks for
- `jobs`: Number of parallel jobs to use during the build process. Default is `auto`, which lets the system decide based on available CPU cores.

- `sign`:
  - `enable`: If set to `true`, enables package signing.
  - `backend`: The backend to use for signing packages. Options are `sop`, `sq`, or `gpg`. Default is `auto`. If default is used the main build process will try to determine the best backend available on the system without user flag.
  - `keyid`: The GPG key ID to use for signing packages. If not specified, the default key will be used.
  - `pause`: If set to `true`, pauses the build process to allow for manual signing.

- `changelog`:
  - `enable`: If set to `true`, enables automatic changelog generation.
  - `iteration`: The iteration number for versioning. This determines how often the version number is incremented. Options are `1` to `99`.
  - `urgency`: The urgency level for the changelog entry. Options are `low`, `medium`, `high`, or `emergency`.
