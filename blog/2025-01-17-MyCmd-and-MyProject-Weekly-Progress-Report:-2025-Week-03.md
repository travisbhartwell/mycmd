# MyCmd and MyProject Weekly Progress Report: 2025 Week 03

I decided to take last week off from working on the project, thus no update for last week. 

## MyProject Demo

My demo-able goal for this week was to implement a minimal MyProject Task Registry and loading a `myproject/main` task definition file and listing the tasks defined there.

![Executing mycmd myproject list-task](../../images/mycmd-myproject-list-tasks-just-main.png)

Again, this demo was simple, but my development methodology is to build and maintain momentum by implementing incremental, testable features.

## MyProject Updates

I pushed [eight commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-01-05&until=2025-01-17) over the last two weeks, including the following:

* Documenting Concepts and Conventions in the [Concepts and Conventions Document](https://github.com/travisbhartwell/myproject/blob/000291b7a3b3aa14e2179037bede6dc31ad28b8b/docs/myproject-concepts-and-conventions.org?plain=1) regarding task definition directories, project root directories, and naming of variables related to these concepts.
* Updating the naming of variables to match the conventions documented above.
* Organizing the library and test files.
* Documenting the design of the Task Registry and added tasks to those.
* A minimal implementation of a Task Registry that only stores the task fully qualified name and the function for the task.
* A minimal loader of a task definition file.

I have made decent incremental progress with these changes.

## Next Week

My next goal is to implement a minimal `mycmd myproject run` that will be able to execute a no-argument task.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

