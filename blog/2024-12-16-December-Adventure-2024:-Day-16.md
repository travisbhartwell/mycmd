# December Adventure 2024: Day 16

## Doom Emacs Configuration: Shell Script Formatting

I pushed [commit 34bf8e17c172e620e067011291e4fe1bd7c3715a](https://github.com/travisbhartwell/dotfiles/commit/34bf8e17c172e620e067011291e4fe1bd7c3715a) to my dotfiles, including changes to use [beautysh](https://pypi.org/project/beautysh/) when formatting Zsh files, since [shfmt](https://github.com/mvdan/sh) doesn't support the Zsh dialect. I also updated the parameters used for `shfmt` when formatting Bash files to match what I am using in my [task runner](https://github.com/travisbhartwell/mycmd/blob/rewrite/mycmd/project/project-shell-lib#L28).

## MyCmd Registry Implementation

More incremental progress on the MyCmd Registry Implementation. I focused on the help and version metadata today.

* [commit 8506cc380b9fa9ecafee33b4d9a621566393fe0f](https://github.com/travisbhartwell/mycmd/commit/8506cc380b9fa9ecafee33b4d9a621566393fe0f): Implement help metadata storage and accessors.
* [commit 2304ef6efe8e95e6382c221829532033ea65c565](https://github.com/travisbhartwell/mycmd/commit/2304ef6efe8e95e6382c221829532033ea65c565): Add help and version registration functions.

Tomorrow I will need to look at the loading functions amd see about combining the loading functions for Commands and Command Groups.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
