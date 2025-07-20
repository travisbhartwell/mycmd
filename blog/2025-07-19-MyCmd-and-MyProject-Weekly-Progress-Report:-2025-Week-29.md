# MyCmd and MyProject Weekly Progress Report: 2025 Week 29

## Demo

This week's demoable goal for MyProject was to implement basic fileset support. A fileset in MyProject is essentially a global array variable that contains lists of files in the project. You can then define tasks that can act on a given fileset.

![mycmd myproject run fileset-task](../../images/mycmd-myproject-run-fileset-task-week29.png)

This shows executing the task `fileset-task`, which is executed on the fileset `DATA_FILES` defined [here](https://github.com/travisbhartwell/myproject/blob/7850c2fcfd39224375a7941f961394ad38502c65/testing/test-data/valid/valid1/myproject/main#L33-L51).

## MyProject Updates

This week I pushed [10 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-07-13&until=2025-07-19) to MyProject, including the following.

- Added a task for running just the snapshot tests.
- Simplified the code for generating coverage data.
- Added a task for creating a new MyProject support library file from a template.
- Implemented basic fileset support.
- Integrated filesets with tasks.

## MyCmd Updates

This week I pushed [2 small commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-07-13&until=2025-07-19) to MyCmd, including:

- Added a task for running just the snapshot tests.
- Simplified the code for generating coverage data.

## Next Week

I will expand the fileset support next week. In my original implementation in MyCmd core, I have `project.find_files_for_fileset`, which allows executing an expression with `GNU find` to add files to a fileset. I think I will also add some convenience functions for iterating filesets in tasks.

I'm getting pretty close to being able to start to dog-food MyProject to build and test itself. I plan on doing a gap analysis and starting that next week.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

