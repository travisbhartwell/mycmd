# MyCmd

Tool for writing and running commands from a command directory.

## MyCmd Key Concepts

1. MyCmd is a tool to execute scripts found in directories in the [MyCmd Search Path](docs/mycmd-path.org). Each of these scripts are in a hierarchical structure.

2. A script that is executed is called a **command**. 

3. However, the **command** script isn't run directly by the user. `mycmd` is a launcher that sets everything up and then runs the specified **command**. When launching, the hierarchy is specified by spaces, and not slashes.

4. Each command is part of a **command group**. Command groups are hierarchical. `mycmd` is the implicit top level command group. The **command group** is the mechanism for grouping related commands together, and also for code reuse. The **command group** consists of a directory named for the command group, as well as a shell library, by convention the **command group** name suffixed by `-lib`. 

5. MyCmd also provides a set of common routines that make writing **commands** easier.

## Development Blog

Read the development log for MyCmd [here](https://iam.travishartwell.net/mycmd/).

## Installation

MyCmd is still pre-release software, but we currently support a few mechanisms for installation.

**Requirements**

To run MyCmd, the following are required:

1. Bash 5.x -- if you are on Mac OS, that means installing from Homebrew or another means, as the `bash` shipped with Mac OS is too old.
2. GNU Coreutils

If you want to use the [logging command group](./mycmd/logging), the following are also required:

1. `script`
2. `fzf`
3. `zcat`

If you are running on Mac OS, you can install those not already included with Mac OS with [Homebrew](https://brew.sh):

``` shell
brew install bash coreutils fzf
```

**Installation with Mise**

You can use the excellent [Mise](https://mise.jdx.dev) to install MyCmd. Assuming you have Mise installed and configured according to the [Getting Started Documentation](https://mise.jdx.dev/getting-started.html), you can install MyCmd by:

``` shell
mise use -g github:travisbhartwell/mycmd
```

Mise handles exposing the `mycmd` command to your `PATH` and thus requires no additional configuration, by default.

**Installation From a Release Tarball**

Get the latest release from the [releases page](https://github.com/travisbhartwell/mycmd/releases/latest). Download the GZipped Tarball attached to the release and untar it. It is recommended to put this in `$HOME/.local/share`. For example, if you have downloaded the first release version, you would do the following:

``` shell
mkdir -p $HOME/.local/share && 
  cd $HOME/.local/share &&
  tar xvf ~/Downloads/mycmd-0.01.tar.gz
```

This will untar the release contents into `$HOME/.local/share/mycmd-0.01`. You can either put `$HOME/.local/share/mycmd-0.01/bin` on your `PATH` in your shell or symlink `$HOME/.local/share/mycmd-0.01/bin/mycmd` into a directory such as `$HOME/.local/bin` that is already on your `PATH`.

**Installation From a Git Checkout**

You could also use a Git checkout, but as MyCmd is still in active development, note that the [main branch](https://github.com/travisbhartwell/mycmd/tree/main) isn't guaranteed to always be in a working state. If you do use a git checkout, it is suggested that you use one of the [tags](https://github.com/travisbhartwell/mycmd/tags). Tag names prefixed with `snapshot-` are interim snapshot releases, and tag names prefixed with `v` are release versions. Again, doing this in `$HOME/.local/share` is suggested. So, for example, to do a git checkout of the initial release, `v0.01`:

``` shell
mkdir -p $HOME/.local/share && 
  cd $HOME/.local/share &&
  git clone --branch v0.01 https://github.com/travisbhartwell/mycmd.git 
```

You can either put `$HOME/.local/share/mycmd/bin` on your `PATH` in your shell or symlink `$HOME/.local/share/mycmd/bin/mycmd` into a directory such as `$HOME/.local/bin` that is already on your `PATH`.

**Development Worktrees**

This is the mechanism I use on my main development machine where I develop MyCmd itself. See the [development documentation](./DEVELOPMENT.md) for more details.

## Inspiration and Similar Projects

* After reading Ian Henry's post, [sd: my script directory](https://ianthehenry.com/posts/sd-my-script-directory/), and realizing the haphazard way I was throwing together scripts at work, I saw that a similar approach could work for me, giving me reuse for common tasks. It has indeed made my life a lot better. My `mycmd` user directory at work now has over 30 scripts spread across over 15 command groups, and it's infinitely easier for me to create one-off scripts that re-use existing functionality from my other commands and command groups.

## License

MyCmd is licensed under the [MIT license](LICENSE.md) and includes other open source software developed by contributors to their respective projects.

These other libraries included in the `vendor` subdirectory have their own licenses, acknowledged here:
* `bashup.events`: Licensed under the [CC0 License](https://creativecommons.org/publicdomain/zero/1.0/). The project repository is at <https://github.com/bashup/events/tree/bash44>.
* `ansi`: Licensed under the [MIT License with a non-advertising clause](https://github.com/fidian/ansi/blob/master/LICENSE.md). The project repository is at <https://github.com/fidian/ansi>.

Additionally, these libraries used for testing MyCmd included in the `testing/vendor` subdirectory have their own licenses, acknowledged here:
* `shunit2`: Licensed under the [Apache License 2.0](https://github.com/kward/shunit2/blob/master/LICENSE). The project repository is at <https://github.com/kward/shunit2>.
