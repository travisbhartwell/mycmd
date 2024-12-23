# December Adventure 2024: Day 22

## MyCmd: General

Today, I did some more small clean up tasks from my list:

* [commit 88ac786653bf2949eb1e57e479eb4eac52ab10d3](https://github.com/travisbhartwell/mycmd/commit/88ac786653bf2949eb1e57e479eb4eac52ab10d3): Re-use the `mycmd:registry._item_exists_for_fully_qualified_name` function.
* [commit f22ec1eedcbb73b6ec3ea64531e7cc74cc3d18dd](https://github.com/travisbhartwell/mycmd/commit/f22ec1eedcbb73b6ec3ea64531e7cc74cc3d18dd): Tests for `mycmd:registry.get_child_commands` and `mycmd:registry.get_child_command_groups`.
* [commit 1944c3e8a1589c5fa518a862ffbdfe89db6ee92c](https://github.com/travisbhartwell/mycmd/commit/1944c3e8a1589c5fa518a862ffbdfe89db6ee92c): Add task `execute-single-file-tests` to allow running just a single test file's tests, or a subset of that file's tests.
* [commit b8917361d11c0353ba1238a9f3ec935accc4d471](https://github.com/travisbhartwell/mycmd/commit/b8917361d11c0353ba1238a9f3ec935accc4d471): Fix a bug in `project.list_files` and add some more project task runner tasks.

## MyCmd Project Task Runner

As I start to think about separating out the project task runner from MyCmd into its own project, I wanted to do an evaluation of everywhere I use it in my personal projects. I put together this meta [myproject file](https://gist.github.com/travisbhartwell/6d0a0bd237eb710af680d3be88807f40) that I use the Mac OS [mdfind](https://ss64.com/mac/mdfind.html) command to find all files named `myproject` on my local system and then symlink them all into place in an archive directory, using the project directory name for the symlink name.

Interestingly, as you can see from the `myproject` file linked, even writing this one exposed bugs and limitations in my current project task runner implementation.

From this I was able to get a line count of my current files, across all of my local projects:

```
Counting source lines in fileset 'ALL_ARCHIVED_FILES'.
    2906 total
    1015 archive/main
     288 archive/life-dashboard
     280 archive/work-log
     245 archive/bashdoc
     227 archive/dialysistracker
     162 archive/travisbhartwell.github.io
     131 archive/myproject
     125 archive/Nova
     120 archive/aspirations
      97 archive/financial-data
      66 archive/financial-importer
      65 archive/dialysis-data
      65 archive/datacleanup
      20 archive/templates
```

It would be interesting to run a diff routine on those to see how much is boilerplate.

## MyCmd: Continuous Integration

I took some time today to take some notes on the upcoming work for getting continuous integration set up for MyCmd using GitHub Actions. I wrote down what I want to accomplish, the questions I might have, and eventual goals. I have only minimally used GitHub Actions and so this will be a learning experience. I've done plenty of CI and release automation in the past with systems like Jenkins and Amazon's internal systems, so this is not an entirely new endeavor for me.

## Personal Dot Files

I pushed a [new commit](https://github.com/travisbhartwell/dotfiles/commit/13153930ce6714fd965f6b562213562e9465f6a4) to remove the work around in my personal MyCmd Command Groups and Commands that supported them being executed with both my previous snapshot and my in-progress rewrite. Now that I use the rewrite everywhere, I updated the code to only use the latest version of the APIs.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
