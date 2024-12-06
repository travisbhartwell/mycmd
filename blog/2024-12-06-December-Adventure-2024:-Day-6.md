# December Adventure 2024: Day 6

## Cognitohazards and Side Quests: Shell Script Profiling: Part 2

### Profiling the Entire MyCmd Execution

I wrote [yesterday](../2024-12-05-december-adventure-2024:-day-5/) about profiling shell scripts and creating flamegraphs. I continued on that path today.

I realized yesterday I generated a trace from just the execution of the `mycmd project list-tasks` command and not the entire execution of MyCmd. I have some separate variables to start the trace at the beginning of MyCmd execution, `_MYCMD_EARLY_SHELL_TRACE` and `_MYCMD_EARLY_TRACE_LOG_FILE`. The leading underscores are because these aren't really for MyCmd users and more for internal development. These do similar to what I linked yesterday, but at the start of [bin/mycmd](https://github.com/travisbhartwell/mycmd/blob/4de5d55d8c337d0d612752fec74bcf6f0830d0e5/bin/mycmd#L8-L28) to trace the entire MyCmd execution.

Re-running with the change to [the mycmd-devel task](https://github.com/travisbhartwell/mycmd/blob/4de5d55d8c337d0d612752fec74bcf6f0830d0e5/myproject#L551-L566) to use the new variables, the following flamegraph is produced:

![mycmd project list-task flamegraph](../../images/mycmd-project-list-tasks-full.svg)

You can also open <a href="../../images/mycmd-project-list-tasks-full.svg" target="_blank">the Flamegraph in a new tab</a> and then click to focus on individual portions of the flamegraph.

I promise I will write a separate development log entry explaining the shell script profiling and flamegraph generation in detail so others can adapt it to their own code and not just in MyCmd. Once I do that, I will update this entry with a link to that post.

### Querying Call Hierarchies

I pushed [commit 4de5d55d8c337d0d612752fec74bcf6f0830d0e5](https://github.com/travisbhartwell/mycmd/commit/4de5d55d8c337d0d612752fec74bcf6f0830d0e5) that included [query-call-hierarchy.py](https://github.com/travisbhartwell/mycmd/blob/4de5d55d8c337d0d612752fec74bcf6f0830d0e5/support/analysis/query-call-hierarchy.py) and an associated task [query-call-hierarchy](https://github.com/travisbhartwell/mycmd/blob/4de5d55d8c337d0d612752fec74bcf6f0830d0e5/myproject#L542-L549) to call it.

![Executing query-call-hierarchy](../../images/query-call-hierarchy.png)

The text output of the above call to `mycmd project run query-call-hierarchy tmp/shell-log-trace mycmd:command_group.register_command_group`

```
The following unique call stacks were found calling 'mycmd:command_group.register_command_group':
---------

mycmd.discover_command_groups_and_commands -> mycmd:pathname.walk_path -> mycmd:pathname.walk_path_for_directory -> mycmd:pathname.walk_path_for_directory -> mycmd.discover_command_groups_and_commands_callback -> mycmd:command_group.register_command_group
---------

mycmd.discover_command_groups_and_commands -> mycmd:pathname.walk_path -> mycmd:pathname.walk_path_for_directory -> mycmd.discover_command_groups_and_commands_callback -> mycmd:command_group.register_command_group
---------

mycmd.discover_command_groups_and_commands -> mycmd:pathname.walk_path -> mycmd:pathname.walk_path_for_directory -> mycmd:pathname.walk_path_for_directory -> mycmd:pathname.walk_path_for_directory -> mycmd.discover_command_groups_and_commands_callback -> mycmd:command_group.register_command_group
---------
```

This is a good first start. I want to update this to output it in a format that [Emacs Compilation Mode](https://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation-Mode.html) can understand so I can easily navigate between the different call sites, so this will include file names and line numbers.

## Other

This was all I felt up to doing today. Hopefully tomorrow I will have energy to write the development log entry and start using the basic query interface to figure out the naming of things as I mentioned yesterday.

## Music

Today was a great new music day.

**Bloodywood Featuring BabyMetal - Bekhauf**

Two of my favorite bands that I've discovered this year, Bloodywood and BabyMetal, released a collaboration, "Bekhauf", which means "Fearless" in Hindi.

It features singing and rapping in English, Hindi, and Japanese. The music video is animated in a style reminiscent of anime. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/skXlKxjlUoo?si=rnLC9MrG9nznPS2S" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

An awesome track, as expected by these bands. I've loved almost every collaboration that BabyMetal has done.

**rosie album by Rosé**

Rosé from the K-Pop group BLACKPINK dropped a new album, "rosie" today:

<iframe style="border-radius:12px" src="https://open.spotify.com/embed/album/7kFyd5oyJdVX2pIi6P4iHE?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>

She's previously released the singles from the album "number one girl", which is emotional and heart-felt, and "APT.", a fun song about a Korean drinking game that's a collaboration with Bruno Mars.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
