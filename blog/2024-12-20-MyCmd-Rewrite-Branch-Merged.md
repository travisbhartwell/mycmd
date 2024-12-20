# MyCmd Rewrite Branch Merged into Main 

I created [this pull request](https://github.com/travisbhartwell/mycmd/pull/3) to merge the long-running `rewrite` branch into mainline. And I approved the pull request, merging into `main`.

This culminates efforts started back in July 2023 to rewrite the MyCmd core to be more modular and easier to test. Then, earlier in this year, I had an idea of how to implement the core data structures in MyCmd, around the Commands and Command Groups. Additionally, I wanted to try discovering all Commands and Command Groups up front, to simplify the command line parsing logic in the MyCmd Launcher. Finally, these changes have paid off and I have merged the changes into the [main branch](https://github.com/travisbhartwell/mycmd/tree/main) and then created a new development snapshot tag, [snapshot-r2-2024-12-20](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r2-2024-12-20), that I am using in my local install of MyCmd to dogfood it.

The efforts of this last year and a half have finally paid off. The cognitive load of understanding, using, and maintaining my code is lighter. More tested. It is easier to write what I need.

I am thankful for [December Adventure](../../december-adventure-2024) giving me the motivation and momentum to get things across this line.

## Summary of the Changes

Using [git-quick-stats](https://github.com/git-quick-stats/git-quick-stats):

```
        Travis B. Hartwell <nafai@travishartwell.net>:
          insertions:    19763  (100%)
          deletions:     9865   (100%)
          files:         574    (100%)
          commits:       149    (100%)
          lines changed: 29628  (100%)
          first commit:  Fri Jul 21 14:48:17 2023 -0700
          last commit:   Fri Dec 20 13:57:16 2024 -0800

        total:
          insertions:    19763  (100%)
          deletions:     9865   (100%)
          files:         574    (100%)
          commits:       149    (100%)
```

The current line counts (including blank and commented lines) of all files (minus a few support files):

```
    7534 total
    1002 myproject
     968 mycmd/mycmd-registry-lib
     414 bin/mycmd
     367 mycmd/project/project-lib
     318 mycmd/project/run
     275 mycmd/project/project-task-lib
     275 mycmd/mycmd-command-group-lib
     273 mycmd/logging/page-log
     256 mycmd/mycmd-pathname-lib
     256 mycmd/logging/log-both
     253 testing/tests/pathname-test
     202 mycmd/mycmd-platform-support-lib
     177 mycmd/project/project-git-lib
     173 mycmd/logging/logging-lib
     172 mycmd/mycmd-command-lib
     167 mycmd/mycmd-event-lifecycle-lib
     157 mycmd/mycmd-loading-base-lib
     148 mycmd/mycmd-output-lib
     146 testing/tests/registry-test
     124 mycmd/mycmd-environment-lib
     122 mycmd/project/list-tasks
     118 mycmd/mycmd-formatted-output-lib
     116 testing/tests/project-lib-test
     101 testing/tests/mycmd-lib-test
      97 testing/tests/environment-test
      85 testing/tests/command-group-test
      78 testing/tests/logging-lib-test
      73 mycmd/mycmd-lib
      70 mycmd/mycmd-loading-lib
      63 testing/tests/init-bin-test
      59 mycmd/logging/summarize-log
      58 mycmd/mycmd-function-calling-lib
      55 testing/tests/command-test
      54 testing/tests/function-redefinition-test
      49 mycmd/mycmd-vendoring-lib
      47 mycmd/mycmd-event-base-lib
      45 mycmd/project/project-shell-lib
      30 testing/tests/event-base-test
      22 testing/user-base/shell/extended/extended-lib
      21 testing/user-base/test-command
      17 mycmd/shell/shell-lib
      17 mycmd/create/create-lib
      14 testing/user-base/test-command-group/test-command-group-lib
```

In brief, these are the things I changed:

* Broke up `mycmd-lib` into smaller support libraries that could be individually loaded and tested.
* Implemented the MyCmd Search Path to define where MyCmd looks for Commands and Command Groups, allowing for tools built using with MyCmd to be installed separately.
* Implemented a common MyCmd Registry data structure that discovers and maintains the data for all Commands and Command Groups. Commands and Command Groups are all discovered on each MyCmd invocation.
* Implemented a common MyCmd Registered Item data structure for instances of Commands and Command Groups, along with aliases and extensions as appropriate for each.
* Followed more consistent conventions for naming and file organization. 
* Adopted git worktrees for managing local development branches as well as a development snapshot to be checked out for use on my development machine.
* Added support for profiling MyCmd Command execution and generating flamegraphs from the profiles.
* Added project tasks to benchmark actions and track history.
* Added tools to catalog and query the function dependencies across the project.

## Next Steps

Before I make an official initial release, I plan on doing the following:

* Separating out the [project task runner](https://github.com/travisbhartwell/mycmd/tree/bd87419ef00738313ad25d9460f2b3aa9515ac58/mycmd/project) into an independent project and repo that depends on MyCmd.
* Get GitHub Actions configured for continuous integration that will:
  * Be executed on pull requests so I can use a pull request workflow.
  * Use MyCmd and the project runner to run tasks to check linting, formatting, and test execution on pull requests.
  * Use MyCmd and the project runner to run tasks to do a snapshot release on merges to `main`.
* Completion support for `mycmd` in major shells (Zsh, Bash, and Fish -- prioritizing Zsh as that is my preferred interactive shell.)
* Implement the `mycmd shell` command group with commands for integrating with interactive shells.
* Write documentation for MyCmd end users.
* Write documentation for MyCmd Command and Command Group writers.
* Implement the `mycmd create` Command Group for creating Commands and Command Groups from templates.
* Figure out installation mechanisms for end users:
  * At minimum, a shell script to do the install.
  * Packages for various package managers.
  * A plugin for [Mise](https://mise.jdx.dev), possibly?
* Feature detection for required Bash features.
* Fix `mycmd.init_bin` to find all requested cross-platform executables all at once.
* Caching of Command and Command Group metadata for even faster execution.

I have spent a lot of time thinking about the changes that I have just merged, and these remaining items have been only vague things I've thought about. So, the coming work might be a bit more challenging. However, I have a much better base to work with and so these changes should be easier than where I was before the rewrite.
