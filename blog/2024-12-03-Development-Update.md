# MyCmd: Development Update

I haven't been keeping up with writing in my development log as I meant to since my [original post](../2024-01-20-mycmd/) back in January; this post is to remedy this.

Admittedly, I'm not as far along as I would like, but I have made decent progress and am pleased with the code I've written so far.

## General Stats

I've continued with work on the [rewrite branch](https://github.com/travisbhartwell/mycmd/tree/rewrite), rebuilding MyCmd from the ground up. Since January, I've made:

* 53 commits
* In those commits, there were 53 files changed, with 4,306 insertions and 1,997 deletions
* [Full Comparison on GitHub](https://github.com/travisbhartwell/mycmd/compare/a91255150d4a1cec03fbcf1facbcaaa3bec06005...2dc1f42a5472819a41c3843a72a5decd7fea1418)

## What I've Done

At a high level, these are some of the changes I've made:

* Split up `mycmd/mycmd-lib` into a bunch of support libraries that can be more independently tested.
* Wrote 37 new test functions across 5 new test files to test those libraries.
* Implemented two new data structures to manage information for Commands and Command Groups (I have a TODO item to write a post explaining the patterns I'm using with these).
* Changed from having just a MyCmd System Directory and a MyCmd User Directory to having a search path (described in [this design document](https://raw.githubusercontent.com/travisbhartwell/mycmd/refs/heads/rewrite/docs/mycmd-path.org)).
* Implemented a new discovery mechanism for Command Groups and Commands.
* Implemented enough of the prior functionality that I can execute existing commands and command groups by hardcoding the calls to them in `bin/mycmd`.
* Added functionality over in [bashdoc](https://github.com/travisbhartwell/bashdoc/) -- see the diff [here](https://github.com/travisbhartwell/bashdoc/compare/feccfe3fb179ba458f905c0b8c1671c3ea600762...b716db84b72ce615bf3aaff493170f8359e2f97d) -- to index the shell files so I can write tools like [this](https://github.com/travisbhartwell/mycmd/blob/rewrite/support/analyze-dependencies.py) to analyze the dependencies between the different libraries in MyCmd.

## The Road Ahead

When I have got the `rewrite` branch back to feature parity of the original implementation, I will merge the brain into the `main` branch. I then aim to get an MVP released for others to try to potentially get more users than just me. My plan is to mark version 0.1 when I have continuous integration / release management configured on GitHub and an installation method other than doing a git checkout.

My next immediate step is to continue cleaning up some of the existing code I've written to be more consistent (following guidelines I'm writing in [this Org-Mode file](https://raw.githubusercontent.com/travisbhartwell/mycmd/refs/heads/rewrite/docs/mycmd-concepts-and-conventions.org)). Then, I will work on getting the MyCmd launcher (`bin/mycmd`) back to feature parity so that it is parsing the command line and can dispatch to arbitrary commands.

I've created this [Org-Mode file](https://raw.githubusercontent.com/travisbhartwell/mycmd/refs/heads/rewrite/docs/mycmd-planning.org) to track the tasks remaining and the milestones ahead.
