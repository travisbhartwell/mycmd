# MyCmd and MyProject Weekly Progress Report: 2025 Week 24

## MyProject Demo

My demoable goals for this week were:
- Clean up the output `mycmd myproject list-tasks` -- sorting tasks from `main` first and listing tasks by their namespaced parts strings instead of fully qualified names.
- Allow arguments at task registration time.
- Allow arguments at task execution time.

These are all shown in the following, which use tasks defined in [this test project](https://github.com/travisbhartwell/myproject/blob/0e2cd4e46d2a0589651946abc6818687016f50b6/testing/test-data/valid/valid1/myproject/).

![Executing mycmd myproject list-tasks and run](../../images/mycmd-myproject-run-arguments.png)

- `task2` (defined [here](https://github.com/travisbhartwell/myproject/blob/0e2cd4e46d2a0589651946abc6818687016f50b6/testing/test-data/valid/valid1/myproject/main#L16-L21)) takes execution-time arguments.
- `task3` (defined [here](https://github.com/travisbhartwell/myproject/blob/0e2cd4e46d2a0589651946abc6818687016f50b6/testing/test-data/valid/valid1/myproject/main#L23-L29)) takes registration-time arguments.

## This Week's MyProject Updates

I pushed [8 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-06-08&until=2025-06-14) this week, including the following changes:

- Cleaning up the `list-tasks` output.
- Handling arguments in `run`.
- Adding global arrays and accessors for task argument related data.
- Updating `project.register_task` to handle arguments.

## Next Week

My plans for next week include the following:
- updating the conventions and concepts document and design document to reflect the latest changes
- cleaning up the test suites. There's a bit of redundancy in some things that I don't need.
- designing and implementing the support for filesets

Filesets are a concept from my original implementation. Essentially a fileset is a global array that has a list of a filenames. Tasks can be registered with filesets and they act on the files in that set. I think I want to make this new implementation a bit cleaner conceptually so I have some things to revisit first.


---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

