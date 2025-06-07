# MyCmd and MyProject Weekly Progress Report: 2025 Week 23

I didn't work on MyCmd or MyProject for a little while and am now getting back into working on it.

## MyProject Demo 

My demoable goal for the week was implementing lazy loading of task definition files other than `main` on demand, adding the ability to execute 0-argument tasks from any task definition file.

Using `mycmd myproject run`, tasks defined in task definition files other than `main` are executed by first specifying the task definition file name, a space, and then the task name.

For example, to execute a task named `task1` in the task definition file named `sub`, such as [this example](https://github.com/travisbhartwell/myproject/blob/8b062212adbc9c713976566933bf33868ccf119a/testing/test-data/valid/valid1/myproject/sub#L7-L10), you would execute `mycmd myproject run sub task1`, as shown here:

![Executing mycmd myproject run sub task1](../../images/mycmd-myproject-run-sub.png)

Note: I will be cleaning up the output of `mycmd myproject list-tasks` as shown above next week to properly show non-`main` tasks appropriately.

## This Week's MyProject Updates

I pushed [4 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-06-01&until=2025-06-07) this week, including these changes:

* Updating the [planning document](https://github.com/travisbhartwell/myproject/blob/8b062212adbc9c713976566933bf33868ccf119a/docs/myproject-planning.org?plain=1) to get it up to date.
* Updated `run` to do simple command line parsing.
* Added support for loading task definition files on demand.

## Previous MyProject and MyCmd Updates

I did make a some small changes before this week, including the following:

**MyCmd**

I pushed [four commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-01-25&until=2025-05-31) to MyCmd, focusing on getting the current code working on Linux (I use Mac OS as my main development environment and haven't done regular testing in a while), as well as adding [Installation Instructions](https://github.com/travisbhartwell/mycmd/tree/24c4da3beff966a7f65f9e26f4f53944aafd78c5?tab=readme-ov-file#installation) to the README.

**MyProject**

I pushed [six commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-01-25&until=2025-05-31) to MyProject. These changes included starting work on supporting multiple task definition files, as well as testing and bootstrapping on Linux.

## Nova

Ever since [Wryl's talk at Handmade Seattle 2024](https://wryl.tech/log/2024/democratizing-software.html), I have been a part of the [Nova Language](https://nouveau.community) community. I have been wanting to work on language implementation and tooling and this has given me that chance. As part of the, I started the [Stellar IDE](https://git.casuallyblue.dev/travisbhartwell/stellar), which is a text-based integrated development environment for the Nova language. I used the awesome [Textual framework](https://textual.textualize.io) to implement this.

I am in the process of rewriting my initial sketch, using [uv](https://docs.astral.sh/uv/) to manage my dependencies, in the [rebuild-with-uv branch](https://git.casuallyblue.dev/travisbhartwell/stellar/src/branch/rebuild-with-uv).

Nova is a multi-stack-based rewriting language, and this little demo shows executing code and then examining the state of the stacks after execution:

<video controls="controls" width="1024">
    <source src="../../images/stellar-demo.mov">
</video>

## Next Week

My first focus next week will be first cleaning up the output of `mycmd myproject list-tasks` and then the first steps towards supporting arguments to tasks.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

