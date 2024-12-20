# December Adventure 2024: Day 20

## MyCmd: Launcher Updates

I finished the core of the MyCmd Launcher functionality today. I can fully parse command-lines, including handling help and version flags.

* [commit 48bb51e87d3de919e1d37b2b8f094982ec946674](https://github.com/travisbhartwell/mycmd/commit/48bb51e87d3de919e1d37b2b8f094982ec946674): Help and version printing functions for Commands and Command Groups.
* [commit 9b5a20e61e7273d957b2e96f959c349997a0d913](https://github.com/travisbhartwell/mycmd/commit/9b5a20e61e7273d957b2e96f959c349997a0d913): Handle command line flags in the launcher.
* [commit d8950690697f97e08273c851d15d1eab0de5d8cf](https://github.com/travisbhartwell/mycmd/commit/d8950690697f97e08273c851d15d1eab0de5d8cf): Clean up the launcher environment before executing a Command.
* [commit 7235fc79475dc1c408f1f9f6ed3cb4dce9a0479e](https://github.com/travisbhartwell/mycmd/commit/7235fc79475dc1c408f1f9f6ed3cb4dce9a0479e): Update the README.

## MyCmd: Merging to main

I finally am at feature parity with my [previous snapshot version](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r1-2024-01-29), and so I created [this pull request](https://github.com/travisbhartwell/mycmd/pull/3) to merge it into the `main` branch. I wanted to see if GitHub CoPilot could be useful as a reviewer and so I added that.

I made the following changes to fix suggestions from CoPilot:

* [commit 9521b86aa0e793b5392b8b2a8337f4fa021a3ebc](https://github.com/travisbhartwell/mycmd/commit/9521b86aa0e793b5392b8b2a8337f4fa021a3ebc): Fix a typo in README.

It appears that CoPilot doesn't recognize the language of some of my files and so it will be less than useful in the future.

I merged the changes into `main`, and wrote [this development log entry](../../2024-12-20-mycmd-rewrite-branch-merged) to celebrate.

## MyCmd: Miscellaneous Changes

After merging with `main`, I had a couple small commits to fix issues I found:

* [commit 0c6532f2cfba40f93a836b3635580faabd0922f6](https://github.com/travisbhartwell/mycmd/commit/0c6532f2cfba40f93a836b3635580faabd0922f6): Handle missing temp working directory.
* [commit bd87419ef00738313ad25d9460f2b3aa9515ac58](https://github.com/travisbhartwell/mycmd/commit/bd87419ef00738313ad25d9460f2b3aa9515ac58): Fix tag listing tasks.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
