# MyCmd and MyProject Weekly Progress Report: 2025 Week 04

## MyProject Demo

My demoable goal for the week was to be able to execute `mycmd myproject run` for tasks with 0 arguments.

![Executing mycmd myproject run](../../images/mycmd-myproject-run-minimal.png)

The above screenshots show executing various tasks defined in this [myproject/main](https://github.com/travisbhartwell/myproject/blob/07c8d5390c80457a139ed80a01c846e19368d63b/testing/test-data/valid/valid1/myproject/main).

## MyProject Updates

I pushed [five commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-01-19&until=2025-01-24) this week, including the following changes:

* Documenting concepts and conventions in the [Concepts and Conventions Document](https://github.com/travisbhartwell/myproject/blob/07c8d5390c80457a139ed80a01c846e19368d63b/docs/myproject-concepts-and-conventions.org?plain=1) and clean-ups related to those documented conventions.
* Moving all user-facing functions (those users call in their own task definition files) into a [support library](https://github.com/travisbhartwell/myproject/blob/07c8d5390c80457a139ed80a01c846e19368d63b/mycmd/myproject/myproject-user-lib) that is loaded from the main library.
* Implemented `project:task.execute` and `project.execute_task` as well as the minimal [run command](https://github.com/travisbhartwell/myproject/blob/07c8d5390c80457a139ed80a01c846e19368d63b/mycmd/myproject/run).

## Next Week

My next area of focus will be supporting multiple task definition files in a project, other than just `myproject/main`. Next week will be basically working on the project internals and then allowing `mycmd myproject list-tasks` and `mycmd myproject run` work with multiple task definition files.

I have been thinking a little bit more about project organization and trying to be more explicit about the differing layers of my systems, between internal implementation, the API surface that is exposed to task definition file writers, and the user interface exposed to those that execute tasks using `mycmd myproject run`. There are many challenges that come from working in an implementation language like Bash and I have some things to think about to make sure my code is the most robust and user friendly.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

