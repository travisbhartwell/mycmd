# December Adventure 2024: Day 5

## MyCmd Development Log

I worked on an outline for a new post in my MyCmd development log, which is about what are essentially higher order functions and functions as first class items in Bash, if you squint. I'll also write about another feature I use in Bash a lot, array references.

I plan on writing and publishing the post tomorrow.

## MyCmd Concepts and Conventions Documentation and Cleanup

I've pushed some commits to document MyCmd concepts and follow naming conventions:

* [7777d95d1077b8f5864ca247ca188a93383c29c7](https://github.com/travisbhartwell/mycmd/commit/7777d95d1077b8f5864ca247ca188a93383c29c7): Documenting and Following Conventions for Help and Version Information
* [e4f84ec543a3fdebe1eae00e796ed21465438152](https://github.com/travisbhartwell/mycmd/commit/e4f84ec543a3fdebe1eae00e796ed21465438152): Start to document general naming conventions

## Cognitohazards and Side Quests: Shell Script Profiling

Since Bash doesn't have anything syntax-wise to support namespaces or objects, I try to "simulate" them by naming conventions of my Bash functions. Bash function names can include periods, colons, and dashes. I realized that I was using colons haphazardly -- both for functions around "object-like" things, like a method for a Command Group, `mycmd:command_group.get_source_directory` and as a general namespace in more general functions, like `mycmd:pathname.is_valid_absolute_path`. I wanted to analyze all of the functions I've written with colons in their names. For things related to "object-like" things, like the Command Group code, I wanted to imagine if this were Python, what would that function be?

* an instance method for an object?
* a class method for a class?
* or, a stand-alone utility function?

I started by looking at `mycmd:command_group.source_file_path_for_directory` (see [mycmd-command-group-lib](https://github.com/travisbhartwell/mycmd/blob/e4f84ec543a3fdebe1eae00e796ed21465438152/mycmd/mycmd-command-group-lib#L102-L115)) and I realized in order to classify it, I needed to see what calls it. I needed the call hierarchy. This brings up one of the challenges I alluded to in [Why Bash?](../2024-12-02-why-bash): I sometimes need to create my own tooling in order to develop Bash in the manner I want.

This made me remember I had some code lying around that allows me to generate [flamegraphs](https://www.brendangregg.com/flamegraphs.html) for profiler visualization from the execution of a shell script. I cleaned this up and committed it in [bec9db54a18b8e66df2f8f71df19dbac2098d2f4](https://github.com/travisbhartwell/mycmd/commit/bec9db54a18b8e66df2f8f71df19dbac2098d2f4). This code uses [flamegraph.pl](https://github.com/brendangregg/FlameGraph) to generate a SVG.

I intend on writing a separate Development Log entry describing this in detail, but briefly:

First, [this code snippet](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/mycmd/mycmd-output-lib#L113-L125):

```shell
    if [[ -n "${MYCMD_SHELL_TRACE-}" ]]; then
        if [[ -n "${MYCMD_TRACE_LOG_FILE-}" ]]; then
            PS4='+[${EPOCHREALTIME}][${BASH_SOURCE}:${LINENO}]:[${FUNCNAME[*]}]:'
            export PS4

            exec {_MYCMD_TRACE_LOG_FD}>>"${MYCMD_TRACE_LOG_FILE}"
            readonly _MYCMD_TRACE_LOG_FD
            export _MYCMD_TRACE_LOG_FD
            BASH_XTRACEFD="${_MYCMD_TRACE_LOG_FD}"
        fi

        set -o xtrace
    fi
```

* Uses the [PS4](https://www.gnu.org/software/bash/manual/bash.html#index-PS4) environment variable to configure what is output when the `-x` is set. This outputs:
  * A `+` for each level of a subshell the line is executed in.
  * The [Epoch Real Time](https://www.gnu.org/software/bash/manual/bash.html#index-EPOCHREALTIME), which is the number of seconds since the Unix Epoch as a floating point value with micro-second granularity, in brackets.
  * The source file name:line number in brackets of the line being executed, followed by a colon.
  * The call stack of the functions called in brackets, separated by spaces and followed by a colon.
  * Finally, the actual code being executed.
* Finally, it uses [BASH_XTRACEFD](https://www.gnu.org/software/bash/manual/bash.html#index-BASH_005fXTRACEFD) to redirect this trace output to a file specified by the `MYCMD_TRACE_LOG_FILE` environment variable.

I then have [support/process-trace-logs.py](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/support/process-trace-logs.py) to convert the output of this `xtrace` output into the perf format required by the `flamegraph.pl` tool.

As an example, this is from the execution of the current [bin/mycmd](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/bin/mycmd), which is hard-coded to execute [mycmd project list-tasks](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/mycmd/project/list-tasks), using the [mycmd-devel task](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/myproject#L545-L553). I then use the [create-flamegraph-from-shell-trace task](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/myproject#L520-L542) to generate the SVG.

![Executing create-flamegraph-from-shell-trace](../../images/create-flamegraph-task.png)

This results in the following flamegraph:

![mycmd project list-task flamegraph](../../images/mycmd-project-list-tasks.svg)

Even as cool as this visualization is, the astute among you might be asking, what does this have to do with my original question of call hierarchy? I can take the code in [support/process-trace-logs.py](https://github.com/travisbhartwell/mycmd/blob/bec9db54a18b8e66df2f8f71df19dbac2098d2f4/support/process-trace-logs.py) and use it to output in a different format the call hierarchy of all of the functions being called. I think I will use this tomorrow to generate a tool to query the relationship among my code as I am figuring out my naming of functions.

## Janet Learning: Aspirations Project

I did a small amount of work on my [aspirations](https://github.com/travisbhartwell/aspirations) project to learn the [Janet Language](https://janet-lang.org).

I published [commit f8085753ba2291080aed8ea8f2c62b3cd6d0ee90](https://github.com/travisbhartwell/aspirations/commit/f8085753ba2291080aed8ea8f2c62b3cd6d0ee90) to add some programming quotes as test data, borrowed from [this page](https://www.codecademy.com/resources/blog/inspirational-coding-quotes/), as I would rather keep my personal aspirations private.

I attempted to add some code to handle the command line arguments in my script, pushed in [commit a421e35db692797396c7475516ca6dd91010d47f](https://github.com/travisbhartwell/aspirations/commit/a421e35db692797396c7475516ca6dd91010d47f). However, I am running into some challenges.

I have been attempting to use a user local install using the `--local` parameter to `jpm` (mentioned in the documentation [here](https://janet-lang.org/docs/jpm.html#User-local-install)) so I could install dependencies into the project local directory `./jpm_tree` instead of a system wide location.

However, when I attempt to use a module from the Janet standard library, such as `os` in the above commit, I get the following error when attempting to do a build:

```
generating executable c source build/aspirations.c from main.janet...
error: could not find module os:
    /Users/travisbhartwell/Developer/Personal/aspirations/jpm_tree/lib/os.jimage
    /Users/travisbhartwell/Developer/Personal/aspirations/jpm_tree/lib/os.janet
    /Users/travisbhartwell/Developer/Personal/aspirations/jpm_tree/lib/os/init.janet
    /Users/travisbhartwell/Developer/Personal/aspirations/jpm_tree/lib/os.so
```

I am sure there is a way around this. I've done a lot today, so I will try to research this problem tomorrow.

## What It Means To Be Open

Someone shared this amazing talk by Lu Wilson from Heart of Clojure 2023, "What it means to be open":

<iframe width="560" height="315" src="https://www.youtube.com/embed/MJzV0CX0q8o?si=IyGSqubbARe-3WdC" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

Lu can be found on [TodePond](https://www.todepond.com).

I found the talk to be very inspiring. I've enjoyed being more open about even the little changes to my dot files on my work log here for December Adventure. This talk and my experience so far motivates me to want to continue this practice even beyond December Adventure. I may not set the goal of a post every day beyond December Adventure, but rather posting whenever I have done something, even a tiny little experience. To quote Lu, "Normalise sharing scrappy fiddles!"

## Tasks for Tomorrow

* Write my development log entry about first class functions and array references in Bash.
* Explore the resolution to my build errors with Janet.
* Build upon my `process-trace-logs.py` script to dump all of the call hierarchies for a given function, to give a similar feature to [IntelliJ's call hierarchy feature](https://www.jetbrains.com/help/idea/viewing-structure-and-hierarchy-of-the-source-code.html#ws_build_hierarchy) for languages it supports.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
