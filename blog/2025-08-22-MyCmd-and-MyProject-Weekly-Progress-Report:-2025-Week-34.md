# MyCmd and MyProject Weekly Progress Report: 2025 Week 34

There is no demo this week, as I added no new features to [MyProject](https://github.com/travisbhartwell/myproject/). All of my changes were clean ups and refactoring.

However, what I did do this week was start to port the `myproject` files (in the format and APIs from the version still in [MyCmd Core](https://github.com/travisbhartwell/mycmd/tree/63fb7ff89245779eb9d6e4f318ea8123f344f6dd/mycmd/project).) from my various personal projects to MyProject task definition files.

## Ports

Here are the commits across my projects showing the conversion. It was helpful to figure out common patterns.

| Project                                                                                                   | Port Commit                                                                                                                                              |
|-----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Aspirations](https://github.com/travisbhartwell/aspirations)                                             | [de93243b67b9d9ea4c02a3d020740d3832d9616b](https://github.com/travisbhartwell/aspirations/commit/de93243b67b9d9ea4c02a3d020740d3832d9616b)               |
| [BashDoc](https://github.com/travisbhartwell/bashdoc/)                                                    | [07a6802eef6a0e53caeed2609bcd06442043f663](https://github.com/travisbhartwell/bashdoc/commit/07a6802eef6a0e53caeed2609bcd06442043f663)                   |
| [Data Cleanup](https://github.com/travisbhartwell/financial-tools/tree/mainline/datacleanup)              | [1572d02f45e1ac170b910554d6520f98310ee4cf](https://github.com/travisbhartwell/financial-tools/commit/1572d02f45e1ac170b910554d6520f98310ee4cf)           |
| [Dialysis Tracker](https://github.com/travisbhartwell/dialysistracker/)                                   | [ad1e6d8854638d26f107f3d0b943cf8ace30c0a2](https://github.com/travisbhartwell/dialysistracker/commit/ad1e6d8854638d26f107f3d0b943cf8ace30c0a2)           |
| [Dot Files](https://github.com/travisbhartwell/dotfiles)                                                  | [d126c9cb13499fe997be116cedfc0889086a17a5](https://github.com/travisbhartwell/dotfiles/commit/d126c9cb13499fe997be116cedfc0889086a17a5)                  |
| [Financial Importer](https://github.com/travisbhartwell/financial-tools/tree/mainline/financial-importer) | [ef35d898b6f296926a548f778ae0a7bed2239ad5](https://github.com/travisbhartwell/financial-tools/commit/ef35d898b6f296926a548f778ae0a7bed2239ad5)           |
| [travisbhartwell.github.io](https://github.com/travisbhartwell/travisbhartwell.github.io/)                | [a30c604d0e8ae48130d342c224931e43cc7bd089](https://github.com/travisbhartwell/travisbhartwell.github.io/commit/a30c604d0e8ae48130d342c224931e43cc7bd089) |
| [Work Log](https://github.com/travisbhartwell/mycmd/tree/work-log)                                        | [d6c1110177b629fb41cc7b2f40239d2af2e61137](https://github.com/travisbhartwell/mycmd/commit/d6c1110177b629fb41cc7b2f40239d2af2e61137)                     |

## MyProject Updates 

This week I pushed [5 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-08-17&until=2025-08-22) to MyProject, including the following changes:

- cleaning up the snapshot tests for `mycmd myproject project-info tasks`, `mycmd myproject project-info task-definition-files`, and `mycmd myproject project-info filesets` 
- refactoring and clean up of the `project-info` command group, removing some redundancy

## Next Week

I have a few remaining projects to finishing porting to MyProject task definition directories, including [MyCmd](https://github.com/travisbhartwell/mycmd/) itself. After I finish with that, I'm going to take some notes on the remaining work to be done in MyProject. I think the main thing I need to do is port the [git support](https://github.com/travisbhartwell/mycmd/blob/63fb7ff89245779eb9d6e4f318ea8123f344f6dd/mycmd/project/project-git-lib) from MyCmd's project implementation into MyProject. With that done, I will be able to create a snapshot tag of MyProject. I will then go back to working on MyCmd and getting it ready for release as well.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

