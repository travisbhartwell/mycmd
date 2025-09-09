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

MyCmd is pre-release software and currently the only method of installation is via git checkout.

**Requirements**

The following are required to run MyCmd:

1. Bash -- likely a 5.x version
2. GNU Coreutils
3. GNU findutils
4. GNU sed
5. GNU grep

If you are running on Mac OS, you can install all of these with [Homebrew](https://brew.sh):

``` shell
brew install bash coreutils findutils gnu-sed grep
```

**Checkout and Installation**

I make git tags with known good snapshots of my in-progress development. I have provided a script to help set up a git worktree with this snapshot in [support/setup-dev-environment.sh](./support/setup-dev-environment.sh). This script will take a parent directory to set up the git checkouts in. This directory cannot be your home directory directly, as `~/mycmd` is the directory reserved for user written command groups and commands.

Additionally, this script was initially meant as a setup for myself to set up my development environment, so the default git URL for the repo is the `git` protocol which uses my ssh id with GitHub to check it out. If you do not want to use a git account, you can just use the http url, by setting the `MYCMD_USE_GIT_HTTPS` environment variable when running `setup-dev-environment.sh`.

Therefore, if we want to check out things in `~/.local/share/mycmd`, do the following:

``` shell
# Uncomment below to use HTTPS protocol for the git checkout
#MYCMD_USE_GIT_HTTPS=1

curl -sSL -O "https://raw.githubusercontent.com/travisbhartwell/mycmd/main/support/setup-dev-environment.sh" \
  && chmod +x setup-dev-environment.sh \
  && ./setup-dev-environment.sh $HOME/.local/share
```

Once this is done, be sure to add the `mycmd/snapshot/bin` directory to your `PATH` in your shell configuration. So, in the case above, that would be the directory `~/.local/share/mycmd/snapshot/bin`. Once that is done, you should be able to run the `mycmd` command.

## Inspiration and Similar Projects

* After reading Ian Henry's post, [sd: my script directory](https://ianthehenry.com/posts/sd-my-script-directory/), and realizing the haphazard way I was throwing together scripts at work, I saw that a similar approach could work for me, giving me reuse for common tasks. It has indeed made my life a lot better. My `mycmd` user directory at work now has over 30 scripts spread across over 15 command groups, and it's infinitely easier for me to create one-off scripts that re-use existing functionality from my other commands and command groups.

## License

MyCmd is licensed under the [MIT license](LICENSE.md) and includes other open source software developed by contributors to their respective projects.

These other libraries included in the `vendor` subdirectory have their own licenses, acknowledged here:
* `bashup.events`: Licensed under the [CC0 License](https://creativecommons.org/publicdomain/zero/1.0/). The project repository is at <https://github.com/bashup/events/tree/bash44>.
* `ansi`: Licensed under the [MIT License with a non-advertising clause](https://github.com/fidian/ansi/blob/master/LICENSE.md). The project repository is at <https://github.com/fidian/ansi>.

Additionally, these libraries used for testing MyCmd included in the `testing/vendor` subdirectory have their own licenses, acknowledged here:
* `shunit2`: Licensed under the [Apache License 2.0](https://github.com/kward/shunit2/blob/master/LICENSE). The project repository is at <https://github.com/kward/shunit2>.
