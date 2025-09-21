# MyCmd and MyProject Weekly Progress Report: 2025 Week 38

## Installing MyCmd and MyProject

This week I finished the release automation work for MyCmd and MyProject, enabling me to create a release locally which uses the [GitHub Cli](https://cli.github.com) to create a release tag and upload release tarballs.

With this work, you can use the [Mise](https://mise.jdx.dev) tool to install and run MyCmd and MyProject. MyCmd requires no extra effort, but because MyProject requires setting the `MYCMD_SEARCH_PATH` environment variable, I had to create a [Mise Tool Plugin](https://mise.jdx.dev/tool-plugin-development.html) to manage the environment variable. To do so, I created [myproject-tool-plugin](https://github.com/travisbhartwell/myproject-tool-plugin) from the [mise-tool-plugin-template](https://github.com/jdx/mise-tool-plugin-template).

To install MyCmd and MyProject, if you have Mise installed and activated, you can now just run the following:

```shell
mise use -g github:travisbhartwell/mycmd
mise plugin install myproject https://github.com/travisbhartwell/myproject-tool-plugin
mise use -g myproject
```

## Demo

I recorded the following demonstration. It is in a fresh Debian 12 Linux Virtual Machine, with the only change before starting to record was turning on dark mode and increasing the terminal font size. The shell script I run is based on the [Mise Getting Started Documentation](https://mise.jdx.dev/getting-started.html), with the addition of installing `git` and `rsync` needed for the MyCmd project execution. I then check out the MyCmd git repository. I do have to run `mise install` twice to install the dependencies from the [mise.toml](https://github.com/travisbhartwell/mycmd/blob/297bb2d83c16884e7a95e12c2823582ead43e5c6/mise.toml) because the first install will install the MyProject Tool Plugin and then the second install will install MyProject.

<iframe width="560" height="315" src="https://www.youtube.com/embed/GB83Yew22Vo?si=P8mC1ZzKWy2GHxLZ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## MyCmd Updates

This week I pushed [8 commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-09-14&until=2025-09-20) to MyCmd, including the following changes:

- Adding new release automation tasks to the MyProject task definition files
- Creating an initial 0.01 release
- Added new installation and development documentation 
- Automatically create the MyCmd User Directory (by default, `$HOME/mycmd`) when executing `mycmd` if needed
- Switch to using XDG directories on all platforms, including Mac OS, as I was persuaded by [this blog post](https://becca.ooo/blog/macos-dotfiles/) that this was the right thing
- Creating the 0.02 release
- Adding a `mise.toml` file for MyCmd dependencies

During this week, I created three snapshot tags and two release tags: [MyCmd git tags](https://github.com/travisbhartwell/mycmd/tags), including the following two releases:

- [v0.01](https://github.com/travisbhartwell/mycmd/releases/tag/v0.01): Initial release of MyCmd
- [v0.02](https://github.com/travisbhartwell/mycmd/releases/tag/v0.02): Creating MyCmd User Directory and using XDG directories

## MyProject Updates

This week I pushed [6 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-09-14&until=2025-09-20) to MyProject, including the following changes:

- Adding new release automation tasks to the MyProject task definition files
- Creating an initial 0.01 release
- Don't depend on a MyCmd checkout for MyProject snapshot tests

During this week, I created two snapshot tags and one release tag: [MyProject git tags](https://github.com/travisbhartwell/myproject/tags), including the initial release:

- [v0.01](https://github.com/travisbhartwell/myproject/releases/tag/v0.01)

## MyProject Mise Tool Plugin Updates

I created the [myproject-tool-plugin](https://github.com/travisbhartwell/myproject-tool-plugin) project to enable installing and managing MyProject with Mise. I pushed [3 commits](https://github.com/travisbhartwell/myproject-tool-plugin/commits/main/?since=2025-09-14&until=2025-09-20) this week to implement the plugin.

I created one release tag this week for the project:

- [v0.01](https://github.com/travisbhartwell/myproject-tool-plugin/releases/tag/v0.0.1)

I had some issues with the CI in GitHub Actions that I need to resolve, but the manual release works well.

## Next Week

I need to update the [MyProject README](https://github.com/travisbhartwell/myproject/blob/75ce3e994cd8248d8ffb28812c3295ed5333def5/README.md) to include installation instructions.

I also accepted a job offer this last week and will be starting my new role in a couple weeks, so I will take some time this next week to figure out what I need to prioritize to have MyCmd and MyProject ready to use in my day to day work in my new employment.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

