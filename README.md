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

* `aur-patch` - TODO.

* `aur-commit` - Performs a number of checks on a package repository and
  commits the changes in a consistent manner. Specifically:

  * Check that either `pkgver` or `pkgrel` have been bumped from last commit.
  * Build the package on the host system.
  * Build the package in a chroot.
  * Install the package on the host system.
  * Run [shfmt](https://github.com/mvdan/sh) on the PKGBUILD.
  * Run [shellcheck](https://github.com/koalaman/shellcheck) on the PKGBUILD.
  * Print [namcap](https://wiki.archlinux.org/title/Namcap) output.

  The idea is to perform as much testing and quality control as possible after
  a change in a package has been done, with a single command. After this
  command has been run, a simple `git push` will publish the update.

## Installation

Clone the repository and run

```sh
make install
```

to install the commands system-wide. Or, run the following to install it for
a your user only:

```sh
PREFIX=~/.local make install
```
