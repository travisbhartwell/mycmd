# December Adventure 2024: A Reflection

December Adventure 2024 was a successful and fun project for me.

## MyCmd

I made significant progress on the [MyCmd project](https://github.com/travisbhartwell/mycmd/), including:

* I created [75 new commits](https://github.com/travisbhartwell/mycmd/compare/44757347cfc3fd0ff4851c7c3d9d2671df896495...88040871bd858b1854112450c473d32aad1387cf).
* I finally got the work I was doing in the `rewrite` branch back to feature parity and created [a pull request](https://github.com/travisbhartwell/mycmd/pull/3) and then merged those changes into the [main branch](https://github.com/travisbhartwell/mycmd/tree/main) and wrote about this in [this development log entry](../2024-12-20-mycmd-rewrite-branch-merged/). This culminates nearly 18 months of effort on this rewrite.
* Created [several snapshots](https://github.com/travisbhartwell/mycmd/tags) for use on my local development machine, with [snapshot-r5-2024-12-28](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r5-2024-12-28) being the latest.

Among all of these, highlights included:

* Realizing that I had implemented an [Entity Component System](../2024-12-17-december-adventure-2024:-day-17/#my-first-entity-component-system) with the [MyCmd Registry](https://github.com/travisbhartwell/mycmd/blob/88040871bd858b1854112450c473d32aad1387cf/mycmd/mycmd-registry-lib) for [Command Groups](https://github.com/travisbhartwell/mycmd/blob/88040871bd858b1854112450c473d32aad1387cf/mycmd/mycmd-command-group-lib) and [Commands](https://github.com/travisbhartwell/mycmd/blob/88040871bd858b1854112450c473d32aad1387cf/mycmd/mycmd-command-lib).
* Adding in support for profiling MyCmd execution and generating flamegraphs, documented on [Day 5](../2024-12-05-december-adventure-2024:-day-5/#cognitohazards-and-side-quests-shell-script-profiling) and [Day 6](../2024-12-06-december-adventure-2024:-day-6/#cognitohazards-and-side-quests-shell-script-profiling-part-2).
* I made written plans in the [MyCmd Planning org-mode document](https://github.com/travisbhartwell/mycmd/blob/88040871bd858b1854112450c473d32aad1387cf/docs/mycmd-planning.org?plain=1) to track remaining work.
* I documented concepts and conventions in the [MyCmd Concepts and Conventions document](https://github.com/travisbhartwell/mycmd/blob/88040871bd858b1854112450c473d32aad1387cf/docs/mycmd-concepts-and-conventions.org?plain=1).

## MyProject

I started a separate MyProject project to rewrite the [mycmd/project Command Group](https://github.com/travisbhartwell/mycmd/tree/88040871bd858b1854112450c473d32aad1387cf/mycmd/project) from the MyCmd core into a separate application that depends on MyCmd.

* I created the [myproject repository](https://github.com/travisbhartwell/myproject) for this.
* I pushed [4 commits](https://github.com/travisbhartwell/myproject/compare/89f3df794ba9dc0b45b0b0e67934d90da67d9be0...552f1db586e69bc195eacc2c0b9bd4cefa6c29f7) to this repository, creating a project skeleton and starting to document design decisions and plans for implementation.

## Development Log

I published a development log entry [every day of December](../../december-adventure-2024) documenting what I did each day.

I also published the following separate entries about MyCmd specifically:

* [Why Bash?](../2024-12-02-why-bash)
* [MyCmd: Development Update](../2024-12-03-development-update/) 
* [MyCmd Rewrite Branch Merged](../2024-12-20-mycmd-rewrite-branch-merged/)

## Dot Files

I pushed [5 commits](https://github.com/travisbhartwell/dotfiles/compare/fc35f7f7c0bcbc274b1283c8bfc907e1bdff324d...1f33de884171ec70099863606f676729263f1008) to my [dotfiles repository](https://github.com/travisbhartwell/dotfiles/) with changes related to:

* Updating my Emacs configuration.
* Updating my personal MyCmd command groups and commands to work with my newly merged changes to MyCmd.

## Janet Learning

I did start learning the [Janet language](https://janet-lang.org), and created a new project, [aspirations](https://github.com/travisbhartwell/aspirations) to learn it. I ran into a little challenge documented [here](../024-12-05-december-adventure-2024:-day-5/#janet-learning-aspirations-project). I got so engaged with the MyCmd work I didn't get back to this, but I plan on it.

## Lessons Learned

1. Incremental and testable changes, in interest of building and maintaining development momentum are essential for me, especially in light of my ADHD.
2. Writing prose is an essential part of my development process:

   * Stream of consciousness style freewriting when figuring out how to implement what is next.
   * Planning and design documents documenting the decisions made in freewriting.
   * Reporting in my development log about my progress.
   
3. Related: working in the open is incredibly motivating.
4. Between sticking with December Adventure for every single day and the progress I made on MyCmd and MyProject by doing so (and the fact that I merged my `rewrite` branch into `main`), I know I can stick with a project long enough to build something I am proud of.

Because of all of these, I will continue to write here in my development log about my progress on MyCmd and MyProject. Going forward, I will allow myself to not stick to the every day schedule like with December Adventure, but on days that I do make changes, I will publish a development log entry to write about it.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
