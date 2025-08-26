---
title: BOA
section: 5
header: Configuration File
footer: BOA 5
authors:
  - Michael Schaecher <michaelschaecher@mlstidbits.com>
date: 2025-08-25
---

# NAME

boa.conf - Configuration file for the BOA

# DESCRIPTION

The `boa.yaml` file is the main configuration file `boa` a `dpkg-buildpackage` wrapper tool. It is used to set various options and parameters that control the behavior of the `boa` tool during the package building process.

# LOCATION

The `boa.yaml` file should be located in the root of the project directory where the `boa` tool is being used. This is typically the same directory that contains the `debian` directory for the package being built.

# OPTIONS

The following options can be set in the `boa.yaml` file:

- `format`: Specifies the format of the configuration file. This should always be set to `yaml`.
- `application`: Specifies the application name. This should always be set to `boa`.
- `build`: Specifies the type of build to perform. Supported options are `source`, `binary`, or `binary,source`.
- `no_pre_clean`: If set to `true`, `boa` will not clean the build environment before building.
- `no_post_clean`: If set to `true`, `boa` will not clean files in the `debian/` directory that should not be tracked by version control.
- `check_builddeps`: If set to `true`, `boa` will check for build dependencies before starting the build process.
- `jobs`: Specifies the number of parallel jobs to use when building packages. Can be set to an integer or `auto` to use the number of available CPU cores.
- `no_sign`: If set to `true`, `boa` will not sign the built packages.
- `sign`: A section that contains options for signing the built packages:
  - `backend`: Specifies the signing backend to use. Supported options are `sop`, `sq`, or `gpg`.
  - `keyid`: Specifies the key ID to use for signing the packages.
  - `pause`: If set to `true`, `boa` will pause before signing the packages to allow for manual intervention.
- `changelog`: A section that contains options for automatically generating changelog entries:
  - `enabled`: If set to `true`, `boa` will automatically generate changelog entries based on the latest git commit message.
  - `iteration`: Specifies how often the version number should be incremented.
  - `urgency`: Specifies the urgency level for the changelog entry. Supported options are `low`, `medium`, `high`, or `emergency`.

# SEE ALSO

dpkg-buildpackage(1), debuild(1), dh(1), dpkg(1), dpkg-source(1), apt(1)

# COPYRIGHT

Copyright (c) 2024 Michael Schaecher <michaelschaecher@mlstidbits.com> all rights reserved.
