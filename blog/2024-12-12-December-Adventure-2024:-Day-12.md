# December Adventure 2024: Day 12

## Git Fun

I had an old git repository that I used to use to track my dotfiles. I wanted to see what files were present at any commit during the entire history of the repository. With help from [this StackOverflow answer](https://stackoverflow.com/a/424142/10873), I came up with the following:

```shell
git rev-list --all | xargs -L 1 -I % git diff-tree --no-commit-id --name-only % -r | sort -u
```

In parts:

* `git rev-list --all`: [git rev-list](https://git-scm.com/docs/git-rev-list) with `--all` will show all commits that reachable from refs listed in `.git/refs`, so all branches.
* `xargs -L 1 -I %`: [xargs](https://www.man7.org/linux/man-pages/man1/xargs.1.html) will run the command following it for every line of input. `-L 1` tells it to use one line per call. The `-i %` means replace that character with the input in the commandline following.
* `git diff-tree --no-commit-id --name-only <commit> -r`: [git diff-tree](https://git-scm.com/docs/git-diff-tree) will compare the listed commit with its parent and show the changed paths.
* `sort -u`: sort the input, removing duplicates.

I love the power of the command line.

## MyCmd Registry Implementation

I continued to work on the implementation of the MyCmd Registry. I pushed a small commit, [commit d638ab4128179ee91a68dadea471297f920c8f6a](https://github.com/travisbhartwell/mycmd/commit/d638ab4128179ee91a68dadea471297f920c8f6a) with some small renames. I have a pretty good idea of where I need to go and the changes I need to make. It was a low-energy day, so I didn't make much progress. However, the changes in progress are basically rewriting the two largest files in my current branch, and so it will be a bit of work.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
