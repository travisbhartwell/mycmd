# December Adventure 2024: Day 21

## MyCmd

I did small clean up tasks today, including fixing a bug that I discovered when trying to recreate my local setup using [setup-dev-environment.sh](https://github.com/travisbhartwell/mycmd/blob/975584c87ce7aad816505451e1af8af5968a5b3b/support/setup-dev-environment.sh).

* [commit 7fc190665fe4243ed59f5fce670357e451a167ab](https://github.com/travisbhartwell/mycmd/commit/7fc190665fe4243ed59f5fce670357e451a167ab): Fix `project.load_task_library`.
* [commit aed0eaaf6cc92044b597921ef6503450984d1c3c](https://github.com/travisbhartwell/mycmd/commit/aed0eaaf6cc92044b597921ef6503450984d1c3c): Clean up and organize planning document.
* [commit 218eb5877d24a932e5b405a00f9c35493e0680a1](https://github.com/travisbhartwell/mycmd/commit/218eb5877d24a932e5b405a00f9c35493e0680a1): Use `mycmd.nullglob_set_wrapper` in `myproject`.
* [commit 975584c87ce7aad816505451e1af8af5968a5b3b](https://github.com/travisbhartwell/mycmd/commit/975584c87ce7aad816505451e1af8af5968a5b3b): Use formatted output in project tests summary.

I am continuing to make incremental progress to meet my December Adventure and keep up momentum towards the MyCmd initial release.

## MyCmd Project Task Runner

I took some time to doing some writing with my [FreeWrite Alpha](https://getfreewrite.com/products/alpha) about the next steps for my project task runner project. I am planning on separating this out into its own project and repository before I create a MyCmd project release. I really like stream of conscious writing for just getting my thoughts out.

From that writing, I have decided these are my next steps to do over the next couple of days:

* Gather all of my `myproject` files (looks like I have 23 locally on my development machine for all of my projects) into one place and audit my patterns and see if these show missing or needed features.
* Audit all of the current code in [mycmd/project](https://github.com/travisbhartwell/mycmd/tree/975584c87ce7aad816505451e1af8af5968a5b3b/mycmd/project); I haven't made any significant changes to this code in almost a year and so I need to remember what past me did.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
