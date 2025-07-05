# MyCmd and MyProject Weekly Progress Report: 2025 Week 27

## MyCmd Demo

After having the satisfaction of having instrumentation and reporting of code coverage of my testing in [MyProject](https://github.com/travisbhartwell/myproject/), I wanted to have the same for [MyCmd](https://github.com/travisbhartwell/mycmd/) as well. Therefore, my demoable goal for this week was to be able to execute the MyCmd build process and show the code coverage.

<video controls="controls" width="1200">
    <source src="../../images/mycmd-project-run-all-week27.mp4">
</video>

I am currently at 68.94% code coverage, and this is without adding any new tests this week to MyCmd.

## This Week's MyCmd Updates

This week I pushed [16 commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-06-29&until=2025-07-05) to MyCmd, including the following changes:

- Updating test execution to use a test output directory for all test log and report files.
- Refactoring the tests to use a common [testing-support-lib](https://github.com/travisbhartwell/mycmd/blob/3b9def82d92e4d56665a623d418c07a05cedb6a1/testing/tests/testing-support-lib).
- Add coverage instrumentation and reporting.
- Rewrite the coverage reporting to handle more kinds of multi-line statements.
- Updating the vendored version of [shunit](https://github.com/kward/shunit2/) to the latest from the `master` branch.
- Improving test coverage.
- Started working on improvements to help test the MyCmd launcher (`bin/mycmd`) and Commands.

I especially like my rewrite of the [coverage reporting](https://github.com/travisbhartwell/mycmd/blob/3b9def82d92e4d56665a623d418c07a05cedb6a1/myproject#L359-L572) that uses state machines to detect and update multi-line statements.

## This Week's MyProject Updates

This week I pushed [5 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-06-29&until=2025-07-05) to MyProject, mostly bringing updates that I made over in MyCmd back to MyProject, including the following changes:

- Moved template files to `support/templates`.
- Moved demo files to `docs/demos`.
- Moved coverage files into a `coverage` subdirectory of the test output directory.
- Updated code coverage reporting to match implementation in MyCmd.
- Updated constant naming in tests to reflect directory names.

## Next Week

I realized this week that I needed a good way of testing invocation of CLI tools and not just the library code. I've started designing a small system for using snapshot testing or golden file testing. I made [some notes](https://github.com/travisbhartwell/mycmd/blob/3b9def82d92e4d56665a623d418c07a05cedb6a1/docs/snapshot-testing.org) about how I want this to look and will work on implementing this next week. This will help me close the gap on code coverage, specially in testing things that are purely producing output. Once I get this working, I will make another snapshot of MyCmd to use locally to then use in testing MyProject.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

