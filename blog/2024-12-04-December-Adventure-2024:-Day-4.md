# December Adventure 2024: Day 4

## Writing / Meta

To better support the increased amount of writing I'm doing this month, I've took some time to improve my tooling.

**New December Adventure Post Generator**

I created a new task for my work log `myproject` file, `new-december-adventure-post` that uses a template to generate a new post for the current day. I pushed this in [commit 511e3dbc4a9c6f099f24c8dfa798d73a8f651701](https://github.com/travisbhartwell/mycmd/commit/511e3dbc4a9c6f099f24c8dfa798d73a8f651701).

![Executing new-december-adventure-post](../../images/new-december-adventure-post.png)

**Post Proofreading Support**

I've made too many typos in my posts this week (just look at my work-log [commit history](https://github.com/travisbhartwell/mycmd/commits/work-log/?since=2024-12-01&until=2024-12-04)). To help with proofreading, I've created `tbh/proofread-file` in my Emacs configuration that uses the `say` command on Mac OS to read the contents of the current buffer with text to speech. Hearing it should help me catch some of my typos and awkward wording and other issues. I've pushed this change to my dotfiles in commit [8dbdce5feefb89ab20e1e0edcb196572c3cac2b4](https://github.com/travisbhartwell/dotfiles/commit/8dbdce5feefb89ab20e1e0edcb196572c3cac2b4).

**Checking Links from Post**

I've created a new task for my work log `myproject` file, `open-all-links` that takes a URL and opens all links from the anchor tags in the content. I will use this to make sure I don't have any typos in any of the links I've added to my documents. It opens the links in batches of 5 so I can check them out in chunks. I've pushed this change to my work-log project in commit [9e44125ee0c657e2fecfb954cac7e5c5b43430d7](https://github.com/travisbhartwell/mycmd/commit/9e44125ee0c657e2fecfb954cac7e5c5b43430d7).

![Executing open-all-links](../../images/open-all-links.png)

## MyCmd Concepts and Conventions Documentation and Cleanup

I've published a couple small commits to document MyCmd concepts and follow naming conventions:
* [bd2c1d24d7dcf53097fadab4f410877b7ba0dbd5](https://github.com/travisbhartwell/mycmd/commit/bd2c1d24d7dcf53097fadab4f410877b7ba0dbd5): Documenting and Following Conventions for Source Files
* [1e8d1da9ea19c84c60167d8268d1e5f60fc90058](https://github.com/travisbhartwell/mycmd/commit/1e8d1da9ea19c84c60167d8268d1e5f60fc90058): Documenting and Following Conventions for Child Commands and Child Command Groups

## Janet Learning

I did a small amount of work on my [aspirations](https://github.com/travisbhartwell/aspirations) project to learn the [Janet Language](https://janet-lang.org).

I added a `format` task to format the Janet files, using the `janet-format` tool from the [spork](https://github.com/janet-lang/spork/) library.

I pushed this in [commit 57fd72c23a63d90e4f6efd5cb5cc594c8125e0b1](https://github.com/travisbhartwell/aspirations/commit/57fd72c23a63d90e4f6efd5cb5cc594c8125e0b1)

## Other

I also attended a co-working session today with folks from the Handmade Seattle community and ended up having some lively and engaging conversations. Felt good to get out and have meaningful connection with like-minded folks.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
