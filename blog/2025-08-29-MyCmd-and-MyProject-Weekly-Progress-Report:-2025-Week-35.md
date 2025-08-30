# MyCmd and MyProject Weekly Progress Report: 2025 Week 35

## Four Years of MyCmd

Yesterday, August 28th, marked four years since I made the [original commit](https://github.com/travisbhartwell/mycmd/commit/f55f126857ece8e29dc0a1cc67fbaf917a8ab651) to [MyCmd](https://github.com/travisbhartwell/mycmd/). Inspired by the desire for code reuse on what were ad hoc scripts in my day to day work, I don't think I had any idea of what it would become. I use MyCmd and the tools I've written with it, such as [MyProject](https://github.com/travisbhartwell/myproject/), in my every day development tasks. The code for MyCmd and MyProject is unit tested and the CLI portions are tested with snapshot tests. I even had code coverage instrumentation and the ability to generate flamegraphs from the trace logs of a MyCmd execution. And soon, I will have release automation via GitHub Actions. All of this from something that was originally just some ad hoc scripts I wrote to gather data during everyday operational work.

## Demos

This week's demoable goal was to execute MyCmd's tasks with MyProject:

<video controls="controls" width="1200">
    <source src="../../images/mycmd-myproject-run-all-week35.mp4">
</video>

## MyProject Updates

This week I pushed [3 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-08-24&until=2025-08-29) to MyProject, including the following changes:

- Port the project git library from [MyCmd Core](https://github.com/travisbhartwell/mycmd/blob/63fb7ff89245779eb9d6e4f318ea8123f344f6dd/mycmd/project/project-git-lib) to a myproject child command group
- Fixed `support/setup-dev-environment.sh` to use MyProject's tasks
- Remove the old `myproject-tasks` file

I have created the [first snapshot tag](https://github.com/travisbhartwell/myproject/releases/tag/snapshot-r0-2025-08-27) for MyProject and created a snapshot working tree locally.

I [updated my dotfiles](https://github.com/travisbhartwell/dotfiles/commit/7a2037cb51acba8965496d5109095a8224c8c58a) to now setup `MYCMD_SEARCH_PATH` to use MyProject from the snapshot worktree and I am now using it everywhere for my local development projects.

## MyCmd Updates

This week I pushed [4 commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-08-24&until=2025-08-29) to MyCmd, including the following changes:

- Port the `myproject` file to a MyProject Task Definition directory
- Update the VHS demo file for `mycmd myproject run all`
- Format and fix lint errors in Python files by executing the new Python tasks added
- Deprecate the `project` command group from MyCmd in favor of MyProject

With this deprecation, I created a new [development snapshot tag](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r9-2025-08-29) and have updated my local snapshot worktree to this.

## Next Week

It's now time to jump back into MyCmd development. I want to create a way for the `mycmd.init_bin` to run all at once at the start.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

