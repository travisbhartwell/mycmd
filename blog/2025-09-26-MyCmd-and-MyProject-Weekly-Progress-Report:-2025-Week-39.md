# MyCmd and MyProject Weekly Progress Report: 2025 Week 39

This week was mostly preparing MyCmd and MyProject to be easier for me to use when I start my new job in October.

I updated my [Doom Emacs](https://github.com/doomemacs/doomemacs) configuration to support running MyProject tasks from within Emacs.

Additionally, I created Homebrew Formulas and a Homebrew Tap for MyCmd so I could install MyCmd and MyProject with [Homebrew](https://brew.sh).

I've only tested this on Mac OS, but you can now install MyCmd and MyProject with the following:

``` shell
brew tap travisbhartwell/mycmd
brew install mycmd myproject
```

Or:

``` shell
brew install travisbhartwell/mycmd/mycmd travisbhartwell/mycmd/myproject
```

These will also install the require Homebrew packages needed to run MyCmd and MyProject as well, if needed.

Note that you will need to follow the caveat displayed when installing MyProject to set the `MYCMD_SEARCH_PATH` environment variable.

## Demo

I captured an example of running a MyProject task from Emacs, while hitting `SPC p m` while editing a file from a MyProject project.

<video controls="controls" width="1200">
    <source src="../../images/emacs-myproject-run-week39.mp4">
</video>

You can see my [mycmd Doom Emacs module here](https://github.com/travisbhartwell/dotfiles/tree/33813923d4cb47c90d64868136472a98bff5daf6/dot_doom.d/modules/tbh/mycmd) and the [keybinding is set here](https://github.com/travisbhartwell/dotfiles/blob/33813923d4cb47c90d64868136472a98bff5daf6/dot_doom.d/config.el#L93-L95).

## MyCmd Updates

This week I pushed [1 commit](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-09-21&until=2025-09-26) to MyCmd this week, updating the [Installation Instructions in the README](https://github.com/travisbhartwell/mycmd/tree/cc2ec3b0209121806a680f2ad42b7d8ffdb4ebf1?tab=readme-ov-file#installation) to add information about the Homebrew tap.

## MyProject Updates

This week I pushed [2 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-09-21&until=2025-09-26) to MyProject, including:

- Adding a `mise.toml` file for build time dependencies of MyProject
- Adding [Installation Instructions in the README](https://github.com/travisbhartwell/myproject/blob/4db06621f42aea09eea0f3ee71bd946cce6576be/README.md#installing-myproject)

## MyCmd Homebrew Tap Updates

This week I created [homebrew-mycmd](https://github.com/travisbhartwell/homebrew-mycmd/), a [Homebrew Tap](https://docs.brew.sh/Taps) or third-party repository for [Homebrew](https://brew.sh) for MyCmd and MyProject. I pushed [4 commits](https://github.com/travisbhartwell/homebrew-mycmd/commits/main/?since=2025-09-21&until=2025-09-26) to the repository, including:

- creating Homebrew formulas for MyCmd and MyProject
- fixing style and other issues with the formulas
- setting MYCMD environment variables to Homebrew paths

## Other Updates

I pushed [3 commits](https://github.com/travisbhartwell/dotfiles/commits/main/?since=2025-09-21&until=2025-09-26) to my [Dot Files](https://github.com/travisbhartwell/dotfiles/) with some updates, most notably, updating my Doom Emacs configuration to support executing MyProject tasks from within Emacs.

## Next Week

I still need to figure out what other features I need to implement in MyCmd and MyProject before I start my next role in October.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

