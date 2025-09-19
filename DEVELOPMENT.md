# MyCmd Development

In addition to the general requirements for running MyCmd documented in the [README](./README.md), there are a few additional requirements for doing development.

MyCmd's project tasks (defined in the [myproject task definition directory](./myproject)) require the separate [MyProject](https://github.com/travisbhartwell/myproject) installed.

It is highly suggested to use [Mise](https://mise.jdx.dev) when developing MyCmd. Follow the Mise [Getting Started Documentation](https://mise.jdx.dev/getting-started.html) to get this installed and configured. There is a [mise.toml](https://mise.jdx.dev/configuration.html) the includes some additional tools.

The included Mise configuration will install MyCmd and MyProject and a few other development tools needed to run the project tasks (`shellcheck`, `shfmt`, `uv`).

After checking out the `MyCmd` git repository, you should run `mise install` once from the `mycmd` git checkout directory once to get these tools installed and set up.

**Other System Requirements**

However, there a few other system requirements as well:

1. GNU Sed
2. GNU Grep
3. GNU Find
4. Rsync

`rsync` is included by default on Mac OS. I suggest [HomeBrew](https://brew.sh) to install the others:

```shell
brew install gnu-sed grep findutils
```

**Additional Information**

This information needs to be updated:

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

