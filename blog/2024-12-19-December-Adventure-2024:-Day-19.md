# December Adventure 2024: Day 19

## MyCmd: Launcher Implementation

Today I did an initial pass at command line parsing in the MyCmd Launcher. In honesty, the rewrite I started back in [July of 2023](https://github.com/travisbhartwell/mycmd/commit/ad2c15c9c928b1cb4f3c3d4814338ff4eb3afd7d), and then the further project to use the Command and Command Group data structures started in [April of this year](https://github.com/travisbhartwell/mycmd/commit/702adc3adce8b1169bcf2fe5c93c4ffb5f768cda) are finally paying off. The difficulty in parsing the command line and detecting valid commands and command groups inspired this whole effort. And I feel like this paid off. I wasn't sure if the up-front discovery of command groups and commands would work fast enough, and yet it does.

* [commit 24eb61cceb600a2242a2c0ca18a96b72d586c8ea](https://github.com/travisbhartwell/mycmd/commit/24eb61cceb600a2242a2c0ca18a96b72d586c8ea): Initial implementation of command line parsing.
* [commit 30ab5151919f92a2d205e43e3dc5dad9d7f0c2e2](https://github.com/travisbhartwell/mycmd/commit/30ab5151919f92a2d205e43e3dc5dad9d7f0c2e2): Don't error when no arguments are on the command line.
* [commit 9ce2e4286c3e56d9af5e9e3f707bf4ef9a347bcf](https://github.com/travisbhartwell/mycmd/commit/9ce2e4286c3e56d9af5e9e3f707bf4ef9a347bcf): Updated the planning document.

With these changes, I can now execute a MyCmd command with the in-development version (the task `mycmd-devel` executes using the local development tree and not the globally installed MyCmd):

![mycmd project run mycmd-devel project list-tasks](../../images/mycmd-devel-project-list-tasks.png)

This has been a long time coming!

## MyCmd: Next Steps

Partly out of eagerness to start dogfooding this branch, I have scaled back the features I wanted to have complete before the MVP, which is when I will merge the `rewrite` branch into `main`. I originally wanted to have interactive completion in Zsh before doing so. However, the [snapshot version](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r1-2024-01-29) I am running on my local development machine does not have completion working either, so this won't be a step back anyway. I have listed these remaining features and tasks in my [planning document](https://raw.githubusercontent.com/travisbhartwell/mycmd/9ce2e4286c3e56d9af5e9e3f707bf4ef9a347bcf/docs/mycmd-planning.org).

I think the features I have remaining for the MVP are pretty straight-forward, and so I hope to have these complete in the next couple of days.

This has been a fruitful December Adventure so far!

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
