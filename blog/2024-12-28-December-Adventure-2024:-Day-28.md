# December Adventure 2024: Day 28

## MyCmd

I pushed [a small commit](https://github.com/travisbhartwell/mycmd/commit/0812052ca7ec20fc25f9619a2f230050f46b83dd) that allows me to use the file name `myproject-tasks` for the existing MyCmd Project Task Runner implementation. This is to enable me to use a `myproject-tasks` file in the new MyProject repository while I am working on it. Once it is dog-foodable, I can switch to using the file structure in the `myproject` directory.

I created a new tag, [snapshot-r4-2024-12-28](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r4-2024-12-28) to use locally for MyCmd to use this on my development machine.

Unfortunately I discovered a bug in that change and had to push [a new commit](https://github.com/travisbhartwell/mycmd/commit/86f3bc27781fb47ac268514f8c832eb8e8bcfe3e) and created a new snapshot, [snapshot-r5-2024-12-28](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r5-2024-12-28).

## MyProject

I pushed a commit, [commit 85767722c10f7feede788bd2c1ddf63c5ff13d99](https://github.com/travisbhartwell/myproject/commit/85767722c10f7feede788bd2c1ddf63c5ff13d99), which fills out the skeleton of the project, including:

* a legacy myproject file for the legacy mycmd/project task runner
* a minimal command group implementation
* a minimal test file for that command group
* a support script for setting up the local development environment
* a planning org-mode file to keep track of plans, tasks, and ideas

I aim to keep making small steps, in interest of building momentum and enabling incremental, testable changes.

## Building a Mechanical Calculator

I watched this amazing video recently, "How I Built a Mechanical Calculator":

<iframe width="560" height="315" src="https://www.youtube.com/embed/E0pJST5mL3A?si=Vx3MThXwejLcff6N" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

I love this video so much, for many reasons. He points out the early efforts to build similar machines took the collaboration of two great minds -- the one figuring out the concepts and ideas and the craftsman building the implementation of those ideas. I love how he took the time to investigate and learn how these early machines work and then use his own talent, wood-working, to replicate those earlier ideas. I love how these machines are manifestations of people examining the processes that they use to perform calculations and then making them physical. In a way, this is the way that any hacker and software developer works. Though our creations are rarely physical, we take what we examine for the processes we need to do, and make them manifest.

## Summary

I am continuing to take it easy today and have some social activities, so today was a light day.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
