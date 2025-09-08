# MyCmd and MyProject Weekly Progress Report: 2025 Week 36

This week ended up being a busy week and so I don't have demo to show, but I will put one together next week to demonstrate that includes this week's changes.

## Graphing The Dependency Between MyCmd Support Libraries

I have split the core MyCmd implementation into a base [mycmd-lib file](https://github.com/travisbhartwell/mycmd/blob/aa101372aac281c5427b834eb28de8f7dbefb68e/mycmd/mycmd-lib) and a set of support library files [in the same directory](https://github.com/travisbhartwell/mycmd/tree/aa101372aac281c5427b834eb28de8f7dbefb68e/mycmd). From each support library file, I only load the other support libraries that are required for that file's functionality. This makes testing each part in isolation in unit tests easier.

This week I was returning to implementing features in MyCmd, after not working on any MyCmd features itself for a few months while I focused on [MyProject](https://github.com/travisbhartwell/myproject/) and testing work. I didn't fully remember the relationship between the files and the loading order. So, I took the time to create a [GraphViz dot file](https://graphviz.org/doc/info/lang.html) (see it [here](https://github.com/travisbhartwell/mycmd/blob/aa101372aac281c5427b834eb28de8f7dbefb68e/docs/mycmd-lib-deps.dot)) with the relationships between these files. In this diagram, `mycmd-lib` refers to the above linked `mycmd-lib` file, and then all of the others refer to the support library file names. For example, `formatted-output` in the diagram maps to [mycmd-formatted-output-lib](https://github.com/travisbhartwell/mycmd/blob/aa101372aac281c5427b834eb28de8f7dbefb68e/mycmd/mycmd-formatted-output-lib).

From this, the following graph is generated:

![mycmd-lib depdencies](../../images/mycmd-lib-deps-week-36.png)

## Cross Platform Binary Support

In MyCmd, I have support in the [mycmd-platform-support-lib](https://github.com/travisbhartwell/mycmd/blob/aa101372aac281c5427b834eb28de8f7dbefb68e/mycmd/mycmd-platform-support-lib), I have support for handling system provided binaries in a cross-platform way. For example, I use `realpath` from [GNU Coreutils](https://www.gnu.org/software/coreutils/), as it offers a bit more features than the `realpath` provided by Mac OS. To do this, I install GNU Coreutils with [HomeBrew](https://brew.sh). But this means GNU `realpath` is installed as `grealpath` (Yes, I know you can get it as `realtpath` by changing your PATH, but I don't want to require that).

In support of this, I have a few functions:

- `mycmd.init_bin` - it uses a mapping in MyCmd to look for the appropriate executable name depending on the platform and errors if it is not found. Often this is called with `mycmd.defer_at_startup` to do this when the library is loaded.
- `mycmd.bin_execute` - I use this to execute the appropriate executable when found

For example, see the following snippet from the `logging` command group, from before this week's changes (see [the source here](https://github.com/travisbhartwell/mycmd/blob/f321cbd550e38c9304343121d59588c67e6b9ce6/mycmd/logging/logging-lib#L37-L46)):

```shell
mycmd.defer_at_startup mycmd.init_bin zcat
function logging.cat_log() {
    local -r log_file="${1}"

    if [[ "${log_file}" =~ .+\.gz$ ]]; then
        mycmd.bin_execute zcat "${log_file}"
    else
        cat "${log_file}"
    fi
}
```

The problem with this mechanism is that if you have multiple calls to `mycmd.defer_at_startup mycmd.init_bin` for various dependencies, it will stop at the first missing dependency. You fix that one, and then it will run and then stop at the next one. I wanted a way to handle this all at once and tell all of the missing dependencies at once. So, this week I added a mechanism to add the dependencies to initialize all in a bench. Now the first line of the above snippet is this (see [the new source here](https://github.com/travisbhartwell/mycmd/blob/aa101372aac281c5427b834eb28de8f7dbefb68e/mycmd/logging/logging-lib#L37-L46)):

```shell
mycmd.add_to_init_bin_batch zcat
```

With this, I now execute the initialize the batch at two separate times:

- First, when `mycmd-lib` and all of its support libraries are loaded
- Secondly, after a command and its command groups have been loaded prior to executing the command 

I did not complete this part this week, but I'm starting to also add this support into MyProject and have it execute the initialize batch after all of the task definition files have been loaded.

## MyCmd Updates

This week I pushed [2 commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-08-31&until=2025-09-06) to MyCmd, including the following changes:

- Adding `mycmd.add_to_init_bin_batch` for batching initialization
- Created a Graphviz Dot file for the `mycmd-lib` and support library dependencies

With this new feature, I created a new [development snapshot tag](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r10-2025-09-05) and have updated my local snapshot worktree to this.

## MyProject Updates

This week I pushed [1 commit](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-08-31&until=2025-09-06) to MyProject, using `mycmd.add_to_init_bin_batch` instead of the old `mycmd.defer_at_startup mycmd.init_bin` pattern for MyProject's system dependencies.

## Other Changes

This week I pushed [2 commits](https://github.com/travisbhartwell/dotfiles/commits/main/?since=2025-08-31&until=2025-09-06) to my dotfiles, including the following changes:

- Cleaned up my Zsh configuration files to unset the temporary functions used during the startup configuration
- Updated my personal MyCmd command groups and commands to use the new `mycmd.add_to_init_bin_batch` function

## Next Week

I need to finish adding support in MyProject to execute the batched bin initialization after loading the MyProject task definition files, and then update all of my task definition files to use the new pattern.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

