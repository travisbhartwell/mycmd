# MyCmd and MyProject Weekly Progress Report: 2025 Week 32

This week I accomplished two main things:

- Adding output control options for verbose and quiet options.
- Creating a new command group for project information.

## Demos

### Output Control Options

The following shows running the [sub a-sub-task](https://github.com/travisbhartwell/myproject/blob/3376af5b474c0c04af131262b476fc3d095ff211/testing/test-data/valid/valid1/myproject/sub#L13-L18) task with normal output, with quiet output enabled, and with verbose output enabled:

![mycmd myproject run output options](../../images/myproject-devel-run-output-flags-week32.png)

### New `project-info` command group

I moved `mycmd myproject list-tasks` to `mycmd myproject project-info tasks` and also created `mycmd myproject project-info root` and `mycmd myproject project-info task-definition-directory`:

![mycmd myproject project-info](../../images/myproject-devel-project-info-week32.png)

## MyProject Updates

This week I pushed [11 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-08-03&until=2025-08-09) to MyProject, including the following changes:

- Added output control options, for quiet mode and verbose mode and exposed these to the end-user.
- Added command line parsing to [mycmd myproject run](https://github.com/travisbhartwell/myproject/blob/3376af5b474c0c04af131262b476fc3d095ff211/mycmd/myproject/run), including `--quiet` and `--verbose` flags.
- Created a new `mycmd myproject project-info` command group for commands to get information about a MyProject project.
- Moved `mycmd myproject list-tasks` to `mycmd myproject project-info tasks`.
- Created `mycmd myproject project-info root` and `mycmd myproject project-info task-definition-directory` to get the project root directory and task definition directory, respectively.

## Next Week

I have local in-progress changes to allow registration of descriptions for tasks. I will use this in more verbose outputs in `mycmd myproject run` and `mycmd myproject project-info tasks` to show these descriptions. Once this is done, I plan on systematically working through the `myproject` files I have across my many projects and porting them to task definition directories. With this, I hope to see if there are any other major features I'm missing and what else I need to do.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

