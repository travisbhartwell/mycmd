# MyCmd and MyProject Weekly Progress Report: 2025 Week 45

I had to do a small update to [MyProject](https://github.com/travisbhartwell/myproject) this week, as I discovered a small bug when using it at work.

## The Bug

In a MyProject task function, you can call `myproject.execute_tasks` to call other tasks. In MyProject, a task can be referenced in two ways. First, with the task name, and second, with the namespaced parts string. As an example, [this task from MyProject's own task definition files](https://github.com/travisbhartwell/myproject/blob/590e5fefbab3484822920bb3745152eceb363ae5/myproject/repo#L280-L290) which is in the `repo` task definition file:

```shell
function clean_dist_directory() {
# Function definition elided for brevity ...


myproject.register_task clean-dist-directory clean_dist_directory
```

The name of this task is `clean-dist-directory`. And because it is in the `repo` task definition file, the namespaced parts string for the task is `repo clean-dist-directory`.

When calling other tasks using `myproject.execute_tasks`, you reference other tasks using the following rules:

- Using their namespaced parts string, i.e. `repo clean-dist-directory`
- For tasks in the same task definition file, just the task name `clean-dist-directory`
- For tasks defined in `main` you can reference them just by the task name, no matter which task definition file you are calling them from

The bug I discovered was when calling `myproject.execute_tasks` and the first task was in another task definition file but the second was in the same task definition file as the current task. I discovered that I wasn't properly restoring the internal accounting of what the current task definition file was and so the tasks from the same task definition file were not found. This was a simple fix.

## MyProject Updates

This week I pushed [2 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-11-02&until=2025-11-08) to MyProject, with the fix to save and restore the internal tracking of the current task definition file when executing tasks, and bumping the MyProject version.

I created and published [release v0.03](https://github.com/travisbhartwell/myproject/releases/tag/v0.03).

## MyCmd Homebrew Tap Updates

I pushed [2 commits](https://github.com/travisbhartwell/homebrew-mycmd/commits/main/?since=2025-11-02&until=2025-11-08) to the [MyCmd Homebrew Tap](https://github.com/travisbhartwell/homebrew-mycmd), updating the MyProject version to the new release.

## Other Projects

I also created a new open source project recently, [URLDataExtractor](https://github.com/travisbhartwell/url_data_extractor). It is a Python library for creating Matchers and Data Extractors. I have used this at work to create a tool to generate Markdown links for URLs from my browser for my daily work notes, based on patterns.

I do need to write some documentation for the project, but you can see [extractor-test.py](https://github.com/travisbhartwell/url_data_extractor/blob/1f208e50ef20ee263d4f2e6571f1b86484e90bba/extractor-test.py) for an example of how you can use the library.

I haven't yet added it to PyPi, but I can add it as a dependency for projects that use [uv](https://docs.astral.sh/uv/) using something like the following:

```shell
uv add --script generate_markdown_links.py git+https://github.com/travisbhartwell/url_data_extractor.git
```

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

