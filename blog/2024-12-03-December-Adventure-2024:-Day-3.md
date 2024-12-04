# December Adventure 2024: Day 3

## MyCmd Related

I have written [MyCmd: Development Update](../2024-12-03-Development-Update/) to summarize the work I've done this year in MyCmd.

I also pushed a [small commit](https://github.com/travisbhartwell/mycmd/commit/4be0803398d1852ca9e68f59945c7c0b524158eb) to add a minimal [myproject file](https://github.com/travisbhartwell/mycmd/blob/4be0803398d1852ca9e68f59945c7c0b524158eb/support/templates/myproject) that I can use as a base in new projects. Eventually, I will have functionality to generate project files using this template. Right now, the file just exists so I can `cp` into a new project and start writing.

I also published a couple small commits to document MyCmd concepts and follow naming conventions:
* [d4ab1745d779cd55d4e0b8eb6c834d08e9e3bf75](https://github.com/travisbhartwell/mycmd/commit/d4ab1745d779cd55d4e0b8eb6c834d08e9e3bf75): Documenting and Following Conventions for Namespaced Parts
* [3bcc589e498bdbfde9a48b8bba290c16d3aaa01e](https://github.com/travisbhartwell/mycmd/commit/3bcc589e498bdbfde9a48b8bba290c16d3aaa01e): Documenting and Following Conventions for Source Directories

Tomorrow, I will continue to work on the concepts and conventions documentation and cleanup.

## Janet

I started learning [the Janet programming language](https://janet-lang.org) today, by starting to read [Janet for Mortals](https://janet.guide/) and [the official Janet docs](https://janet-lang.org/docs/index.html).

I found these additional useful resources in my study:
* [Awesome Janet](https://github.com/ahungry/awesome-janet): A curated list of libraries and tooling for the Janet language
* [Powered by Janet](https://goto-engineering.github.io/powered-by-janet/): A collection of all things written in Janet
* [JanetDocs](https://janetdocs.com): A community documentation site for the Janet language.

I started this simple [aspirations project](https://github.com/travisbhartwell/aspirations) as a first little project to learn Janet. I use a set what I've termed "aspirations" that I repeat to myself while exercising and at other times to focus on my mind and remind me of who I am and how I want to live my life. I've been doing this for four months now and I have 15 such statements so far, and I write new ones each month. I primarily focus on the new aspirations each month, but every few days I review statements from past months to keep them fresh. The purpose of the project is two fold:

* Generate a random list of statements to review on my review days.
* I recently purchased the [TRMNL device](https://usetrmnl.com) and I want to write a custom plugin to show a random aspiration on it. This code will push a new statement to the server to be displayed via a webhook.

I've got a minimal Janet project created. Tomorrow, I will add a dependency on [spork](https://github.com/janet-lang/spork) primarily so I can add a task to format my Janet code to my project..

## Dot Files

I pushed a [small commit](https://github.com/travisbhartwell/dotfiles/commit/fc35f7f7c0bcbc274b1283c8bfc907e1bdff324d) to my dotfiles repository with a few random changes, including installing Janet from Homebrew and adding Janet support to my Doom Emacs configuration.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).

