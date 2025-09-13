# MyCmd and MyProject Weekly Progress Report: 2025 Week 37

This week I finished integrating the batch bin initialization support to [MyProject](https://github.com/travisbhartwell/myproject/) and reflected that update in all of my MyProject task definition directories. I also began working on release automation for [MyCmd](https://github.com/travisbhartwell/mycmd/) and MyProject.

## Demo

This week's demoable goal was to demonstrate what it looks like when required system dependencies (indicated via `mycmd.add_to_init_bin_batch` calls) are missing. This example is from [this test task definition file](https://github.com/travisbhartwell/myproject/blob/782a0219ad4d99fc6d0bb76f2480bc03cb03d20c/testing/test-data/valid/valid6/myproject/main#L5-L7) and the MyProject execution.

![missing system dependencies](../../images/myproject-batched-init-week37.png)

A similar error message would be shown for missing dependencies from a MyCmd command or command group.

## MyCmd Updates

This week I pushed [7 commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-09-07&until=2025-09-13) to MyCmd, including the following changes:

- Using `mycmd.add_to_init_bin_batch` in the project task definition files
- Several updates to [setup-dev-environment.sh](https://github.com/travisbhartwell/mycmd/blob/8194564edd36c246d18532e6852c2c5ab99a2586/support/setup-dev-environment.sh)
- Handling `bin/mycmd` as a symlink
- Switch to using `declare -F` instead of `compgen`, which is not always available in non-interactive Bash instances

These changes also include my first contributions via two pull requests:

- [Fix tiny typo in setup-dev-environment.sh](https://github.com/travisbhartwell/mycmd/pull/4)
- [Suggest ~/.local/share installation](https://github.com/travisbhartwell/mycmd/pull/5)

Thanks to my friend [Justin Hill](https://github.com/booniepepper) for these contributions! He was helping me test my current supported installation methods via `git` using `setup-dev-environment.sh` and fixed one error and updated the README. Thanks, Justin!

With these changes, I created a new [development snapshot tag](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r11-2025-09-08) and have updated my local snapshot worktree to this.

## MyProject Updates

This week I pushed [4 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-09-07&until=2025-09-13) to MyProject, with the following changes:

- Call `mycmd.batch_init_bin` after loading a task definition directory
- Using `mycmd.add_to_init_bin_batch` in the project task definition files
- Added some info to `setup-dev-environment.sh`
- Added missing metadata to the `project-info` and `git` child command groups

With these changes, I created a new [development snapshot tag](https://github.com/travisbhartwell/myproject/releases/tag/snapshot-r1-2025-09-08) and have updated my local snapshot worktree to this.

## Other Changes

This week I pushed [2 commits](https://github.com/travisbhartwell/dotfiles/commits/main/?since=2025-08-31&until=2025-09-06) to my dotfiles, including the following changes:

- Cleaned up my Zsh configuration files to unset the temporary functions used during the startup configuration
- Updated my personal MyCmd command groups and commands to use the new `mycmd.add_to_init_bin_batch` function

## Next Week

I need to finish adding support in MyProject to execute the batched bin initialization after loading the MyProject task definition files, and then update all of my task definition files to use the new pattern.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

