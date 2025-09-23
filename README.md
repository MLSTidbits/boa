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
- Supports multiple architectures (amd64, arm64, etc.)
- Auto semantic versioning VIA git logs
- Generates Debian changelog
- Define package signing using GPG

## Installation

The best way to install **BOA** is to add the [repository](https://archive.mlstidbits.com/) to your system's package manager and install it using `apt`. Then update your package list and install with `sudo apt update && sudo apt install boa --yes`

## Configuration

To use **BOA**, you need to create a `.env` file in the root of your project. This file should contain the following variables:

### Environment Variables

#### Build Options

| Variable          | Description                                              | Value                                  |
| ----------------- | -------------------------------------------------------- | -------------------------------------- |
| `BUILD`           | What type of build you want to perform.                  | `binary`, `source` or `both`           |
| `PRE_CLEAN`       | Whether to clean the build directory before building.    | `true` or `false`                      |
| `POST_CLEAN`      | Whether to clean the build directory after building.     | `true` or `false`                      |
| `CHECK_BUILDDEPS` | Whether to check for build dependencies before building. | `true` or `false`                      |
| `JOBS`            | Number of cores/threads to use for building.             | `auto` or Integer value (e.g., `4`)    |

#### Signing Options

| Variable          | Description                                              | Value                                  |
| ----------------- | -------------------------------------------------------- | -------------------------------------- |
| `SIGN`            | Whether to sign the package using GPG.                   | `true` or `false`                      |
| `BACKEND`         | The backend to use for building the package.             | `gpg`, `sop` or `sq`                   |
| `PAUSE`           | Whether to pause before signing the package.             | `true` or `false`                      |

#### Changelog Options

| Variable          | Description                                              | Value                                  |
| ----------------- | -------------------------------------------------------- | -------------------------------------- |
| `CHANGELOG`       | Whether to generate a changelog from git commits.        | `true` or `false`                      |
| `URGENCY`         | The urgency level for the changelog.                     | `low`, `medium`, `high` or `emergency` |

## Usage

To build a DEB package using **BOA**, navigate to the root of your project and run the following command and run `boa` in your terminal. If no `.env` file is found, it will use the default values. Once the build boa transfers the build process to `dpkg-buildpackage` and handles the rest.

## TODO

- [] Complete `dpkg-buildpackage` options support.
- [] Add option to manual install packages.

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE](COPYING) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
