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

These changes also include the first contributions from someone other than myself via two pull requests:

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

## Task Definition File Changes

After finalizing support for `mycmd.batch_init_bin` in MyProject, I updated all of my task definition files across my projects to use this new `mycmd.add_to_init_bin` pattern instead of `mycmd.defer_at_startup mycmd.init_bin`. The following commits were made:

| Project                                                                                                   | Port Commit                                                                                                                                              |
|-----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Aspirations](https://github.com/travisbhartwell/aspirations)                                             | [eafec46babeadbfe71dc75f08bc2044d69fbc34c](https://github.com/travisbhartwell/aspirations/commit/eafec46babeadbfe71dc75f08bc2044d69fbc34c)               |
| [BashDoc](https://github.com/travisbhartwell/bashdoc/)                                                    | [ecafac44ad1c332771987c99e81d7b76bb3d66c2](https://github.com/travisbhartwell/bashdoc/commit/ecafac44ad1c332771987c99e81d7b76bb3d66c2)                   |
| [Data Cleanup](https://github.com/travisbhartwell/financial-tools/tree/mainline/datacleanup)              | [5150a23615f9f38b6cb69e6168478a9f4536c3ce](https://github.com/travisbhartwell/financial-tools/commit/5150a23615f9f38b6cb69e6168478a9f4536c3ce)           |
| [Dialysis Tracker](https://github.com/travisbhartwell/dialysistracker/)                                   | [b763fe7a2d9b8581ac90abc41e73bb5232a7fb7e](https://github.com/travisbhartwell/dialysistracker/commit/b763fe7a2d9b8581ac90abc41e73bb5232a7fb7e)           |
| [Dot Files](https://github.com/travisbhartwell/dotfiles)                                                  | [ffd5f8401c2a1c274d589b19d6ff10b0dfc51e1b](https://github.com/travisbhartwell/dotfiles/commit/ffd5f8401c2a1c274d589b19d6ff10b0dfc51e1b)                  |
| [Financial Importer](https://github.com/travisbhartwell/financial-tools/tree/mainline/financial-importer) | [51bd51a5a0277b2b93335e2c6599d6e0a4f80e3b](https://github.com/travisbhartwell/financial-tools/commit/51bd51a5a0277b2b93335e2c6599d6e0a4f80e3b)           |
| [travisbhartwell.github.io](https://github.com/travisbhartwell/travisbhartwell.github.io/)                | [df6c456d07cef2a05c58016f338a63779c398b75](https://github.com/travisbhartwell/travisbhartwell.github.io/commit/df6c456d07cef2a05c58016f338a63779c398b75) |
| [Work Log](https://github.com/travisbhartwell/mycmd/tree/work-log)                                        | [df0ae0ed757f195570e6d74de476956f4be3a699](https://github.com/travisbhartwell/mycmd/commit/df0ae0ed757f195570e6d74de476956f4be3a699)                     |

## Other Changes

I haven't yet committed or pushed these changes, but I have some in-progress work of automating the release process of MyCmd and MyProject. This includes tasks for creating release tarballs, tasks for updating the version metadata in the source files that are used when calling `mycmd --version`, and other related changes.

## Next Week

I will continue to work on release automation this next week as well as dive into what my official supported installation mechanism might be.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

