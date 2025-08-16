# MyCmd and MyProject Weekly Progress Report: 2025 Week 33

This week, I added features in these major areas in MyProject:

- Ability to register optional task descriptions for tasks.
- Ability to register optional task definition file descriptions for task definition files.
- Added a new project info command to display the task definition files for a project.
- Added a new project info command to display the registered filesets for a project.

## Demos

### Showing Task Descriptions in Run's Verbose Output

The following shows running the [sub a-sub-task](https://github.com/travisbhartwell/myproject/blob/3d311bb7328aec7728b39d0780d4a58319231b69/testing/test-data/valid/valid1/myproject/sub#L16-L22) task with verbose output, which shows the registered task description:

![mycmd myproject run verbose](../../images/myproject-devel-run-verbose-week33.png)

### Showing Task Descriptions in Project Info Tasks

I have moved `mycmd myproject list-tasks` to `mycmd myproject project-info tasks` and added a new default `table` output format (along with the former format, now called `plain`). The `table` format shows the task descriptions, if registered. The following shows the tasks for the [valid1 test project](https://github.com/travisbhartwell/myproject/tree/3d311bb7328aec7728b39d0780d4a58319231b69/testing/test-data/valid/valid1/):

![mycmd myproject project-info tasks](../../images/myproject-devel-project-info-tasks-week33.png)

### Project Info Filesets

I have created a new command, `mycmd myproject project-info filesets` that shows the filesets defined in a project. The following shows the filesets for the [valid1 test project](https://github.com/travisbhartwell/myproject/tree/3d311bb7328aec7728b39d0780d4a58319231b69/testing/test-data/valid/valid1/):

![mycmd myproject project-info filesets](../../images/myproject-devel-project-info-filesets-week33.png)

## MyProject Updates

This week I pushed [ commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-08-10&until=2025-08-15) to MyProject, including the following changes:

- Added support for registering optional task descriptions.
- Moved `mycmd myproject list-tasks` to `mycmd myproject project-info tasks`.
- Added a table-based output format for `project-info tasks` that shows the task descriptions.
- Added the task description to the output in `mycmd myproject run` with the verbose flag.
- Added support for registering optional task definition file descriptions.
- Added `mycmd myproject project-info task-definition-files` to list the task definition files in a project.
- Added `mycmd myproject project-info filesets` to list the filesets in a project.
- Added plain and table output format options for the `filesets`, `tasks`, and `task-definition-files` commands, as well as a quiet flag.

## Next Week

I have some cleanups to do through the code and tests that I want to handle next week. After that, I think I'm pretty much feature complete. After this, before I do a complete release, I do want to go back and make sure I'm handling all of the error cases and that error messages are better. For example, when there are errors in registration of tasks, I want to output the task definition source line that is the source of the issue.

After my cleanups, I will start the planned work to systematically work through the `myproject` files across my personal projects and port them to MyProject and task definition directories.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

