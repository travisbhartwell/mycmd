# MyCmd and MyProject Weekly Progress Report: 2025 Week 31

## Calling Tasks From Other Tasks

This week was a little bit of a struggle as I was trying to figure out some design decisions in [MyProject](https://github.com/travisbhartwell/myproject/). I was primarily working on the capability to call tasks from other tasks.

As a reminder, in MyProject, projects tasks are defined in one or more task definition files in a `myproject` task definition directory -- for example [this](https://github.com/travisbhartwell/myproject/tree/52ceed47d94f2931b25150ce2a3865b3826dbf1c/myproject) is MyProject's own task definition directory.

When executing tasks with `mycmd myproject run`, tasks that are defined in the [main task definition file](https://github.com/travisbhartwell/myproject/tree/52ceed47d94f2931b25150ce2a3865b3826dbf1c/myproject/main), you simply use the task name that is registered with the call to `myproject.register_task`. To execute tasks defined in any other task definition file, you specify the task by the file name and the task name, like `test execute-all` to execute task [execute-all in the test file](https://github.com/travisbhartwell/myproject/blob/52ceed47d94f2931b25150ce2a3865b3826dbf1c/myproject/test#L61-L63).

Because of this, to avoid ambiguity, I have made it so you cannot declare a task with the same name as another file. For example, if you have a task definition file named `sub`, you cannot register a task in `main` named `sub`.

However, I have now added the functionality for tasks to call other tasks, via `myproject.execute_task` and `myproject.execute_tasks`. As a convenience, you can call other tasks defined in the same file by just using their task name, without having to specify the filename. Because of this, there is a potential for ambiguity. Users could define tasks with the same name in the `main` file and other tasks files. So, my work this week was to report these ambiguities.

But I ran into issues when writing tests for this. The code was throwing errors when it shouldn't have. I felt stuck.

## Simplify, Simplify, Simplify

I ended up taking a couple day break from MyProject, but was pondering how to handle the bit of challenge I was in. But, this morning while writing my Morning Pages, I had a realization. The complication in my code was because I had implemented lazy loading for task files. When `mycmd myproject run` is called, only the `main` file is loaded until a task from another file was referenced. But this lazy loading was causing issues when trying to see if a task name referenced in an execute task call existed.

But then I honestly realized that I didn't need lazy loading. Loading a large task definition directory is fast. The design decision to split up MyProject task definitions into multiple files was not to optimize evaluation time. It was to help with the cognitive overhead of having all of the task things in one single file. The [myproject tasks file](https://github.com/travisbhartwell/myproject/tree/52ceed47d94f2931b25150ce2a3865b3826dbf1c/myproject-tasks) in the old format is the largest source file in the MyProject by over two times. So to make it easier for task definition file writers and for the namespacing of task names, I split things up into separate files. But lazy loading wasn't a necessary contributor to those benefits.

With that realization, I pushed [this commit](https://github.com/travisbhartwell/myproject/commit/a0b264bdab72cf3d2fbb6d1308a5fcd249df465b) that removed over 200 lines in implementation and test code. Things are simpler. And my previous ambiguity reporting code is now working as expected.

The lessons?

- Designing software is hard and takes time to get right.
- Simplify. Simplify. Simplify. Build on core concepts and do all you can to make sure that things added build towards those concepts. Remove anything that isn't necessary.
- Sometimes it takes taking a break and stepping away for a moment to figure stuff out.

## Demo

This week's demo is demonstrating the reporting of an ambiguous `myproject.execute_task` call, in this case [sub task3](https://github.com/travisbhartwell/myproject/blob/52ceed47d94f2931b25150ce2a3865b3826dbf1c/testing/test-data/valid/valid1/myproject/sub#L24-L28) from one of the projects in MyProject test data. This task is trying to execute `task2`. This is ambiguous because there is a `task2` defined both in the `sub` file and in the `main` file.

![mycmd myproject run sub task2](../../images/myproject-devel-run-sub-task3-week31.png)

## MyProject Updates

This week I pushed [7 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-07-27&until=2025-08-02) to MyProject this week, including the following:

- A couple of attempts to work to properly report ambiguities.
- Removing the ability to lazy load task definition files, simplifying things.
- Bringing the test coverage back up to 100%.
 
## Next Week

This took a little longer than I would have liked. I will be able to spent time next week to add convenience methods for verbosity output control. And then possibly starting to port MyProject files for my other projects to task definition directories.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

