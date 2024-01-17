# aurutils-extras

This is my collection of custom commands for
[aurutils](https://github.com/AladW/aurutils). The goal is to reduce the amount
of work required to maintain high-quality PKGBUILDs by doing more things with
fewer inputs.

## Usage

* `aur-db-init` - Create a local pacman database with one command:

  ```sh
  $ aur db-init
  ==> Creating updated database file '/var/lib/repo/custom/custom.db.tar.gz'
  ==> WARNING: No packages remain, creating empty database.
  ==> Signing database 'custom.db.tar.gz'...
    -> Created signature file 'custom.db.tar.gz.sig'
  ==> WARNING: No packages remain, creating empty database.
  ==> Signing database 'custom.files.tar.gz'...
    -> Created signature file 'custom.files.tar.gz.sig'
  ```

* `aur-install` - Install a package from the AUR, i.e. sync the package to
  local database and install it using pacman.

  ```sh
  aur install $package
  ```

* `aur-remove` - Remove a package from the local database. (Taken from the man
  pages of aurutils).

  ```sh
  aur remove $package
  ```

* `aur-patch` - Given a source directory, output a patch on `stdout`. Creating
  an `.orig` directory and doing the actual changes must be done beforehand.

  ```sh
  cp -r software-1.0 software-1.0.orig
  # Do changes to software-1.0
  aur patch software-1.0 > my_patch.patch
  ```

* `aur-geninteg` - Partly a wrapper around `makepkg --geninteg` that formats
  the `sha256sums` array like I prefer it. Also able to handle architecture
  specific sources like `source_x86_64`.

  ```sh
  $ aur geninteg
  sha256sums=(
    '2dd18b5460fff9c84edaf3eb7401357e8d311c3e63564db8c5adcb63e54877af'
    'ce685eb1894ce9bf7b1310d7519798d3f234307b064cbca0442ba63b6e203c5a'
    '4411cbed6aba2144daba08eae8ae99868a8939be8ecc7f6160623dd6cf4b9a6f'
    '436a9a293424fb7d48a8fd61fff7d63985dec56d6170cd2fbae24fe03ef98136'
  )
  ```

  ```sh
  $ aur geninteg
  sha256sums_x86_64=('aa82c3e9241503b52db1827e3fd7fc099da74f828ba032e9b726e50c72b4bee5')
  sha256sums_armv7h=('6a5b31ef2a4976aa20e5e39a47acab0575f189c8d66895c0e341d6e2a6442681')
  sha256sums_aarch64=('13d317610ba133c002990c40622a886989368460451809861f378c25730989f4')
  ```

* `aur-commit` - Performs a number of checks on a package repository and
  commits the changes in a consistent manner. Specifically:

  * Update SRCINFO.
  * Check that either `pkgver` or `pkgrel` have been bumped since the last
    commit.
  * Run [shfmt](https://github.com/mvdan/sh) on the PKGBUILD.
  * Run [shellcheck](https://github.com/koalaman/shellcheck) on the PKGBUILD.
  * Build the package on the host system.
  * Build the package in a chroot.
  * Install the package on the host system.
  * Print [namcap](https://wiki.archlinux.org/title/Namcap) output.

  The idea is to perform as much testing and quality control as possible after
  a change in a package has been done, with a single command. After this
  command has been run, a simple `git push` will publish the update.

* `aur-list-pkgs` - Lists all packages maintained or co-maintained by a
  specific user (defaults to `$USER`). Use the option `-b/--pkgbase` to unique
  package bases instead of packages.

  ```sh
  $ aur list-pkgs --user carsme
  aicommits
  antora-cli
  antora-site-generator
  archivebox
  ...
  uim
  vpn-unlimited-bin
  watchman
  yajsv
  ```

## Installation

To install the commands system-wide, clone the repository and run:

```sh
make install
```

Or, run the following to install it for a your user only:

```sh
PREFIX=~/.local make install
```

You can also install the executables to `~/.local/bin` as symlinks by running:

```sh
PREFIX=~/.local make install-symlinks
```
