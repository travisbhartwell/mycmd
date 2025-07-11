# MyCmd and MyProject Weekly Progress Report: 2025 Week 28

This week's demoable goal was to get a snapshot testing framework up and going so I could test CLI execution and compare output to a known good state. I was able to do this.

To implement a snapshot test, I build upon my [shunit2](https://github.com/kward/shunit2) based testing. Each snapshot test consists of three functions, each with the same suffix for the test case name:

- A `test_` function executed by `shunit2` that calls a function to execute the snapshot and assert the exit code. I could add other asserts here as well.
- A `snapshot_` function that has the commands to execute for testing; capturing the output of these commands.
- A `filter_` function that processes the output captured from the snapshot function. With this, I strip any output the could be run or machine specific, such as timestamps, full pathnames, etc.

Here is an example test case: [list tasks invalid project test case](https://github.com/travisbhartwell/myproject/blob/6e2e8db8472f10cbdd786f5cd421ef0655d22b45/testing/tests/list-tasks-snapshot-test#L46-L59).

In the assert function, the filtered output from the test execution is compared against the stored expected snapshot from the [testing/snapshots](https://github.com/travisbhartwell/myproject/tree/6e2e8db8472f10cbdd786f5cd421ef0655d22b45/testing/snapshots) directory.

## Demo

Now, I have the command `update-all-snapshots` to update the expected snapshot files in `testing/snapshots`. This will verify that the command snapshot command exits with the expected exit code and then stores the filtered output.

<video controls="controls" width="1200">
    <source src="../../images/mymd-project-run-update-all-snapshots-week28.mp4">
</video>

And now, executing the full project build:

<video controls="controls" width="1200">
    <source src="../../images/mycmd-project-run-all-week28.mp4">
</video>

With this, I am now at 100% code coverage for MyProject, including the `run` and `list-tasks` command files that were not tested before.

Over on the MyCmd side, I am at 59.45% code coverage. This is actually down from the 68.94% code coverage from last week, despite increasing the number of lines covered by new snapshot tests, because I have updated my coverage reporting to take into account all implementation files, and not just those that were tested, so it now includes the commands from the `logging` and `project` command groups. I will go back and address those later.

I'm actually pretty happy the core mechanisms for executing snapshot tests, capturing snapshots, and processing them was all in less than  [200 lines of code](https://github.com/travisbhartwell/myproject/blob/6e2e8db8472f10cbdd786f5cd421ef0655d22b45/testing/tests/testing-support-lib#L121-L291). It's great when simple code can accomplish so much.

## This Week's MyCmd Updates

This week I pushed [21 commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-07-06&until=2025-07-11) to MyCmd, including the following changes:

- Various additions and annotations to improve test coverage.
- Adding a new output file descriptor just for error reporting on `stderr`, and added `mycmd.error_output` to use with that. The existing `mycmd.log` is reserved for debug and trace logging output.
- Updated most uses of `mycmd.log` intended for reporting errors to users to use `mycmd.error_output`.
- Implementing a snapshot testing framework.
- Various cleanups of constant and function naming.

I also published a new snapshot [snapshot-r8-2025-07-10](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r8-2025-07-10) that I am using locally as my MyCmd build that has these new features available.

## This Week's MyProject Updates

This week I pushed [11 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-07-06&until=2025-07-11) to MyProject, including the following changes:

- Updating my code to use the new `mycmd.error_output` function.
- Porting the changes from MyCmd over for snapshot testing.
- Added snapshot tests for the two commands, `myproject list-tasks` and `myproject run`.

## Next Week

Now that I've taken a three week detour to improve my testing, including adding instrumentation and reporting of code coverage of tests and adding snapshot testing support, next week I am going to get back into MyProject development in earnest and add support for file sets. My hope is that I can start migrating the large single-file [myproject file](https://github.com/travisbhartwell/myproject/blob/6e2e8db8472f10cbdd786f5cd421ef0655d22b45/myproject-tasks) for MyProject itself into a `myproject` task definition directory, with separate files and start to use it to build itself.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

