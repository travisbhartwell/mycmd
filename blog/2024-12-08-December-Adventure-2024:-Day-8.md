# December Adventure 2024: Day 8

## MyCmd: Call Hierarchy Query

I pushed [commit 934df52f64349474cf8ec19fe56d96290eb08451](https://github.com/travisbhartwell/mycmd/commit/934df52f64349474cf8ec19fe56d96290eb08451) to update `query-call-hierarchy.py` to also display the unique immediate callers of a function.

For example, running `mycmd project run query-call-hierarchy tmp/shell-log-trace mycmd:command_group.source_file_path_for_directory` now produces:

```
The following unique call stacks were foun
---------
mycmd.discover_command_groups_and_commands -> mycmd:pathname.walk_path -> mycmd:pathname.walk_path_for_directory -> mycmd.discover_command_groups_and_commands_callback -> mycmd:command_group.register_command_group -> mycmd:command_group.source_file_path_for_directory
---------
mycmd.discover_command_groups_and_commands -> mycmd:pathname.walk_path -> mycmd:pathname.walk_path_for_directory -> mycmd:pathname.walk_path_for_directory -> mycmd:pathname.walk_path_for_directory -> mycmd.discover_command_groups_and_commands_callback -> mycmd:command_group.register_command_group -> mycmd:command_grou
p.source_file_path_for_directory
---------
mycmd.discover_command_groups_and_commands -> mycmd:pathname.walk_path -> mycmd:pathname.walk_path_for_directory -> mycmd:pathname.walk_path_for_directory -> mycmd.discover_command_groups_and_commands_callback -> mycmd:command_group.register_command_group -> mycmd:command_group.source_file_path_for_directory
---------
The following unique callers called 'mycmd:command_group.source_file_path_for_directory':
---------
mycmd:command_group.register_command_group
```

The caveat with this tool is that it will only show the calls that happened during the execution of MyCmd that was traced. In this example, `mycmd:command_group.source_file_path_for_directory` is actually called from two places:

* In [mycmd:command_group.validate_directory_contains_command_group](https://github.com/travisbhartwell/mycmd/blob/934df52f64349474cf8ec19fe56d96290eb08451/mycmd/mycmd-command-group-lib#L135)
* In [mycmd:command_group.register_command_group](https://github.com/travisbhartwell/mycmd/blob/934df52f64349474cf8ec19fe56d96290eb08451/mycmd/mycmd-command-group-lib#L245)

However, as a optimization mechanism, `mycmd:command_group.validate_directory_contains_command_group` is not called during the discovery process, as it already guaranteed to be on the MyCmd search path.

## MyCmd Cleaning Up the Command Group Code

I made decent progress on implementing the concept of the Command Group Registry that I wrote about [yesterday](../2024-12-07-december-adventure-2024:-day-7/#tangent-over-what-ive-implemented-in-mycmd-command-group-lib).

I try to make small, incremental steps. I've got into a pretty good rhythm of making a change, running `mycmd project run all` (which does linting, formatting, and executing tests) and then making a commit:

* [9d0744720e2bdad142fcd86b7dc31300b39cf79f](https://github.com/travisbhartwell/mycmd/commit/9d0744720e2bdad142fcd86b7dc31300b39cf79f): Document the Command Group Registry Concept and Re-arrange `mycmd-command-group-lib` to reflect the concept.
* [9e9008dcabfcc12e8260b57e9b0480ccb43bb85e](https://github.com/travisbhartwell/mycmd/commit/9e9008dcabfcc12e8260b57e9b0480ccb43bb85e): Rename the Command Group Registry related functions.
* [2f35df9bfd6d12e53db8a4bfc61a3c7c403344d7](https://github.com/travisbhartwell/mycmd/commit/2f35df9bfd6d12e53db8a4bfc61a3c7c403344d7): Add outline/organizational comments.
* [c518d5555912afda0eb32d76524a3675c75f1fa0](https://github.com/travisbhartwell/mycmd/commit/c518d5555912afda0eb32d76524a3675c75f1fa0): Moving Command Group Accessor Functions next.
* [677c56cfea30fd0722be4587b8145b5ef4962262](https://github.com/travisbhartwell/mycmd/commit/677c56cfea30fd0722be4587b8145b5ef4962262): Moving Command Group Help Printing Functions next.
* [dda6569074b3ad349c09cbf2c39a6a2a27b2c8c7](https://github.com/travisbhartwell/mycmd/commit/dda6569074b3ad349c09cbf2c39a6a2a27b2c8c7): Moving Command Group Loading Functions next.
* [4c57ebf22525841c0a7462a72552bc9efa9338f1](https://github.com/travisbhartwell/mycmd/commit/4c57ebf22525841c0a7462a72552bc9efa9338f1): Moving Command Group Private Accessor Helper Functions next.
* [cde67285e2f7ec22c1ba61986d151093462f581d](https://github.com/travisbhartwell/mycmd/commit/cde67285e2f7ec22c1ba61986d151093462f581d): Moving Command Group Private Loading Helper Functions next.
* [8a4986081122a7eae06c2a8e363e57b6cde8b517](https://github.com/travisbhartwell/mycmd/commit/8a4986081122a7eae06c2a8e363e57b6cde8b517): Renaming Command Group Private Functions.

I think this was a good start for cleaning up my code. As an easier look at the changes I made today, see this [commit comparison](https://github.com/travisbhartwell/mycmd/compare/934df52f64349474cf8ec19fe56d96290eb0845...8a4986081122a7eae06c2a8e363e57b6cde8b517).

## Next Steps

Tomorrow, I will make similar changes for [mycmd-command-lib](https://github.com/travisbhartwell/mycmd/blob/8a4986081122a7eae06c2a8e363e57b6cde8b517/mycmd/mycmd-command-lib), which implements the Command data structure. After I finish that, I want to look more closely at things to see if it makes sense to move the Command Group Registry and Command Registry into their own files, along with the discovery functions that are in `mycmd-lib`.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
