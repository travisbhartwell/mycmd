# December Adventure 2024: Day 26

## MyCmd Project

I pushed a [small commit](https://github.com/travisbhartwell/mycmd/commit/fd9a536a0c8874608b460e777ed4abd998d279bb) that added some placeholder Markdown documentation files in the [docs directory](https://github.com/travisbhartwell/mycmd/tree/fd9a536a0c8874608b460e777ed4abd998d279bb/docs).

## MyCmd Project Task Runner

Currently, I define tasks for MyCmd's project task runner in a single file named `myproject`. Currently, the [myproject file for MyCmd](https://github.com/travisbhartwell/mycmd/blob/fd9a536a0c8874608b460e777ed4abd998d279bb/myproject) is over 1,000 lines. I feel like this is getting a little unwieldy. Because of that, I have considered a different approach. Today, I made the following notes on this:

1. Throw out the single `myproject` file.
2. Create a `myproject` or `.myproject` directory in the project root.
3. Tasks are defined in one or more files in the `myproject` directory, where `myproject/main` is the only file required.
4. By convention, project-wide constants and fileset definitions are in the `myproject/main` file.
5. All definitions in `myproject/main` are implicitly shared across the other files in the `myproject` directory.
6. When tasks are defined outside of `myproject/main`, they are referenced first by their file name and then the task. For example, if the task `source-files` is defined in `myproject/count`, it would be executed by `mycmd project run count source-files`.
7. Tasks defined in `myproject/main` are just referenced by their name alone. For example, the `all` task in `myproject/main` is executed by `mycmd project run all`.
8. A default task can be registered for the entire project, and can be executed by simply calling `mycmd project run` with no task name.
9. A default task can be registered for each file in the `myproject` directory; these can be executed by simply using the file name they are in. So if the task `all-source-lines` is registered as the default task in the `myproject/count` file, it can be executed just by doing `mycmd project run count`.

Given these ideas, I decided to do an experiment. I took the current [myproject file for MyCmd](https://github.com/travisbhartwell/mycmd/blob/fd9a536a0c8874608b460e777ed4abd998d279bb/myproject) and split it up into separate files. I have put this experiment in [this gist](https://gist.github.com/travisbhartwell/326095ed0a1211270c6a2351a2d83862). If I compare the number of non-blank and non-comment lines between the original `myproject` file and this set of files, there are currently just a dozen or so more lines in the split definition.  The largest file, `snapshot` has just over 300 non-blank lines. That's a lot easier to manage.

In this experiment, I divided the current `myproject` up into the following files, all of which would be in a `myproject` directory in the MyCmd project root:

* `main`: Constant and fileset definitions and general task definitions.
* `benchmark`: Benchmarking tasks.
* `count`: Source file line counting tasks.
* `devel`: Tasks for executing in-development code.
* `functions`: Function cataloging and query tasks.
* `list`: Tasks for listing files in filesets.
* `profile`: Tasks for profiling MyCmd execution.
* `snapshot`: Tasks for dealing with git snapshot worktrees.
* `test`: Tasks for executing tasks.
* `vendor`: Tasks for handling vendored code.

The following table shows the existing task name and the new name that it would have in the new structure:

| Current Task Name                                             | New Task Name                                                 |
|---------------------------------------------------------------|---------------------------------------------------------------|
| `all`                                                         | `all`                                                         |
| `benchmark-help`                                              | `benchmark help`                                              |
| `benchmark-list-project-tasks`                                | `benchmark list-project-tasks`                                |
| `benchmark-mycmd`                                             | `benchmark mycmd`                                             |
| `catalog-mycmd-lib-function-call-tree`                        | `functions catalog-mycmd-lib-function-call-tree`              |
| `catalog-mycmd-lib-function-callers`                          | `functions catalog-mycmd-lib-function-callers`                |
| `clean-up`                                                    | `clean-up`                                                    |
| `count-all-source-lines`                                      | `count all-source-lines`                                      |
| `count-implementation-source-lines`                           | `count implementation-source-lines`                           |
| `count-mycmd-lib-source-lines`                                | `count mycmd-lib-source-lines`                                |
| `count-test-source-lines`                                     | `count test-source-lines`                                     |
| `create-flamegraph-from-shell-trace`                          | `profile create-flamegraph-from-shell-trace`                  |
| `create-local-snapshot`                                       | `snapshot create-local`                                       |
| `execute-all-tests`                                           | `test execute-all`                                            |
| `execute-single-file-tests`                                   | `test execute-single-file`                                    |
| `format`                                                      | `format`                                                      |
| `git-quick-stats`                                             | `git-quick-stats`                                             |
| `index-mycmd-lib`                                             | `functions index-mycmd-lib`                                   |
| `lint`                                                        | `lint`                                                        |
| `list-all-files`                                              | `list all-files`                                              |
| `list-development-snapshots`                                  | `snapshot list-development`                                   |
| `list-implementation-files`                                   | `list implementation-files`                                   |
| `list-local-snapshots`                                        | `snapshot list-local`                                         |
| `list-mycmd-lib-files`                                        | `list mycmd-lib-files`                                        |
| `list-mycmd-lib-functions`                                    | `functions list-mycmd-lib-functions`                          |
| `list-mycmd-lib-functions-with-source-file`                   | `functions list-mycmd-lib-functions-with-source-file`         |
| `list-test-files`                                             | `list test-files`                                             |
| `mycmd-devel`                                                 | `devel mycmd`                                                 |
| `page-last-test-log`                                          | `test page-last-log`                                          |
| `promote-latest-local-snapshot-to-development`                | `snapshot promote-latest-local-to-development`                |
| `promote-local-snapshot-to-development`                       | `snapshot promote-local-to-development`                       |
| `query-call-hierarchy`                                        | `functions query-call-hierarchy`                              |
| `remove-test-logs`                                            | `test remove-logs`                                            |
| `rollback-snapshot-worktree-to-last-used-snapshot`            | `snapshot rollback-snapshot-worktree-to-last-used`            |
| `rollback-snapshot-worktree-to-previous-snapshot-in-sequence` | `snapshot rollback-snapshot-worktree-to-previous-in-sequence` |
| `test-command-directly`                                       | `devel test-command`                                          |
| `update-ansi`                                                 | `vendor update-ansi`                                          |
| `update-bashup-events`                                        | `vendor update-bashup-events`                                 |
| `update-shunit2`                                              | `vendor update-shunit2`                                       |
| `update-snapshot-worktree-to-latest-development-snapshot`     | `snapshot update-snapshot-worktree-to-latest-development`     |
| `update-snapshot-worktree-to-latest-local-snapshot`           | `snapshot update-snapshot-worktree-to-latest-local`           |
| `update-snapshot-worktree-to-snapshot`                        | `snapshot update-snapshot-worktree-to-snapshot`               |

Note that the project task runner will eventually have command line completion, so even if some of the names are long, completion will make that simpler. Also, the most common tasks can be registered as default tasks for their file, so for example `test execute-all` would be the default for `test`, and so I could run this with `mycmd project run test`.

This feels like a potential path forward. I still have some major ideas to work through before I move forward.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
