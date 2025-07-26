# MyCmd and MyProject Weekly Progress Report: 2025 Week 30

## Demo

My demoable goal for the week was to be able to execute MyProject's own project tasks with itself, which required 1) implementing a few new features, and 2) porting the single task definition file using the APIs of the old version to a task definition directory using the new APIs. And with these changes, I can now run MyProject's project tasks with itself:

<video controls="controls" width="1200">
    <source src="../../images/myproject-devel-run-all-week30.mp4">
</video>

And here is the output of running `mycmd myproject list-tasks` for MyProject itself:

![mycmd myproject list-tasks](../../images/myproject-devel-list-tasks-week30.png)

## Porting to a Task Definition Directory

This work required changing the [large single task definition file](https://github.com/travisbhartwell/myproject/blob/87c89980e242e31e8b140e23f474bc1cdee7a775/myproject-tasks) to a [task definition directory](https://github.com/travisbhartwell/myproject/tree/87c89980e242e31e8b140e23f474bc1cdee7a775/myproject). With this porting work, I updated some of the task names to use the naming hierarchy afforded by the multiple task definition files.

The following table lists the differences between the old and new tasks:

| Old Task Name                                               | New Task File | New Task Name                                               |
|-------------------------------------------------------------|---------------|-------------------------------------------------------------|
| all                                                         | main          | all                                                         |
| clean-up                                                    | main          | clean-up                                                    |
| format                                                      | main          | format                                                      |
| lint                                                        | main          | lint                                                        |
| myproject-devel                                             | main          | myproject-devel                                             |
| record-demo                                                 | main          | record-demo                                                 |
| list-all-files                                              | list          | all-files                                                   |
| list-implementation-files                                   | list          | implementation-files                                        |
| list-snapshot-files                                         | list          | snapshot-files                                              |
| list-snapshot-test-files                                    | list          | snapshot-test-files                                         |
| list-test-files                                             | list          | test-files                                                  |
| count-all-source-lines                                      | metrics       | count-all-source-lines                                      |
| count-implementation-source-lines                           | metrics       | count-implementation-source-lines                           |
| count-test-source-lines                                     | metrics       | count-test-source-lines                                     |
| git-quick-stats                                             | metrics       | git-quick-stats                                             |
| create-local-snapshot                                       | repo          | create-local-snapshot                                       |
| list-development-snapshots                                  | repo          | list-development-snapshots                                  |
| list-local-snapshots                                        | repo          | list-local-snapshots                                        |
| promote-latest-local-snapshot-to-development                | repo          | promote-latest-local-snapshot-to-development                |
| promote-local-snapshot-to-development                       | repo          | promote-local-snapshot-to-development                       |
| rollback-snapshot-worktree-to-last-used-snapshot            | repo          | rollback-snapshot-worktree-to-last-used-snapshot            |
| rollback-snapshot-worktree-to-previous-snapshot-in-sequence | repo          | rollback-snapshot-worktree-to-previous-snapshot-in-sequence |
| update-snapshot-worktree-to-latest-development-snapshot     | repo          | update-snapshot-worktree-to-latest-development-snapshot     |
| update-snapshot-worktree-to-latest-local-snapshot           | repo          | update-snapshot-worktree-to-latest-local-snapshot           |
| update-snapshot-worktree-to-snapshot                        | repo          | update-snapshot-worktree-to-snapshot                        |
| new-snapshot-test-file                                      | templates     | new-snapshot-test-file                                      |
| new-support-library-from-template                           | templates     | new-support-library                                         |
| new-test-file                                               | templates     | new-test-file                                               |
| execute-all-tests                                           | test          | execute-all                                                 |
| execute-single-file-tests                                   | test          | execute-single-file                                         |
| execute-snapshot-tests                                      | test          | execute-snapshots                                           |
| page-last-test-coverage-reports                             | test          | page-last-coverage-reports                                  |
| page-last-test-log                                          | test          | page-last-log                                               |
| remove-test-output                                          | test          | remove-output                                               |
| update-all-snapshots                                        | test          | update-all-snapshots                                        |
| update-single-file-snapshots                                | test          | update-single-file-snapshots                                |
| update-shunit2                                              | vendor        | update-shunit2                                              |

A few notes:
- I still have to figure out how I want to share code between projects. In the old version, this was done via project support libraries. I may still do this with this version.
- To get around this, I copied the two functions from [project-shell-lib](https://github.com/travisbhartwell/mycmd/blob/63fb7ff89245779eb9d6e4f318ea8123f344f6dd/mycmd/project/project-shell-lib) in the implementation in MyCmd core right into `main` for now.
- However, I haven't yet copied over [project-git-lib](https://github.com/travisbhartwell/mycmd/blob/63fb7ff89245779eb9d6e4f318ea8123f344f6dd/mycmd/project/project-git-lib), and so the tasks in [myproject/repo](https://github.com/travisbhartwell/myproject/blob/87c89980e242e31e8b140e23f474bc1cdee7a775/myproject/repo) currently will not work.
- I still have to implement functionality around verbose and quiet output and so those changes will need to be made as well.

## MyProject Updates

This week I pushed [11 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-07-20&until=2025-07-24) to MyProject, including the following changes:

- Adding `myproject.for_each_in_fileset` and `myproject.list_files`.
- Implemented `find_and_add_files` that allows using GNU find to add files to a fileset.
- Separating out task execution functions into a new [support library](https://github.com/travisbhartwell/myproject/blob/87c89980e242e31e8b140e23f474bc1cdee7a775/mycmd/myproject/myproject-execution-lib), `myproject-execution-lib`.
- Refactored `project.execute_task` to handle task resolution in a new function, and providing a new internal object, the execution task.
- Implemented `project.execute_tasks` to handle executing multiple tasks. Tasks are specified using their namespaced name (for tasks defined outside of the `main` task definition file, that is the file name and then the task name, so `sub task1`). Tasks are separated by an escaped semicolon (`\;`) in the call to `project.execute_tasks`.
- Exposed task execution to task definition files via `myproject.execute_task` and `myproject.execute_tasks`.
- Ported my existing task definition file for MyProject itself from the single file used with the old implementation into a new task definition directory.

I was pretty happy that I was able to stick with my goal of doing, on average, two hours of work each work day this week on MyProject and with the amount of progress I've made.

## Next Week

I've also spent some time this week writing about how to handle ambiguity in resolution and execution of tasks -- for example, what if a task in `main` and one of the other task definition files has the same name? I have some ideas on what to do there. I will pick up with getting those things documented properly and implemented next week. I need to expand my testing a bit to make sure I fully cover the new code I've implemented this week in automated tests. And then I need to add functionality for handling verbosity and other output controls.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

