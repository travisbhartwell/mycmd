# December Adventure 2024: Day 7

## Writing / Meta

Yesterday, after I published my [December Adventure entry](../2024-12-06-december-adventure-2024:-day-6/), I pushed [a small commit](https://github.com/travisbhartwell/mycmd/commit/a3475277ad3bec1dbcaa98e47f64ff0c970e11e6) to my static site generator to use Pandoc's Markdown format instead of CommonMark. This seems to work for my limited use of Markdown and it gives me the [auto_identifiers extension](https://www.uv.es/wiki/pandoc_manual_2.7.3.wiki?36), which automatically assigns ids to headings, making it possible to link to specific headings in a post.

## MyCmd Naming Conventions Cleanup

I returned to my naming conventions and code clean up task, by looking at [mycmd-command-group-lib](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-group-lib) which implements the Command Group concept. As I mentioned in [Day 5](../2024-12-05-december-adventure-2024:-day-5/#cognitohazards-and-side-quests-shell-script-profiling), I wanted to look at it as if this code was in Python, and answer this for each function:

* Is it an instance method for an object?
* Or, is it a class method for a class?
* Or, is it a stand-alone utility function?

I took a listing of just the function names from `mycmd-command-group-lib` and started annotating them. As I was writing, I realized that I was, in fact, implementing two different "objects" in this file. To describe this, I need to make a bit of a tangent.

## MyCmd Development Pattern: "Pseudo-Structs"

A pattern that I have adopted in several places in the MyCmd code base is what I've come to call "Pseudo-Structs". Bash does not natively support structured data like a struct in C or a class in an object-oriented language. However, I was implementing several concepts that were essentially that, an "object" with groups of related data and operations. For example, the Command Group -- see [these comments](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-group-lib#L35-L70) that describe the data elements of a Command Group.

I realized earlier this year that I could use an associative array, which Bash does support, as such an item. An associative array with hard-coded keys would represent the attributes of the object I was describing. But how do I keep multiple instances of these? What I decided on was to have a set of global associative arrays, one for each attribute on the instance associative array. I have an id that represents each instance, and those are the keys in each of the global arrays.

A few links to show the current implementation of Command Groups:

* [The global associative arrays](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-group-lib#L72-L87).
* [The field names for the instance associative array](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-group-lib#L92-L100).
* [The function for getting an instance of a Command Group](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-group-lib#L273-L323).

One thing I take advantage of here is array reference variables. In Bash, you can pass an array to a function by just referring to its name. (Another aside -- did you know that Bash has dynamic scoping?) In the function called, you declare a variable with `-n` to say that it is an array reference.

Here's an example of using this to call a method on a Command Group instance, taken from [this function to display command group help](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-lib#L220-L252):

```shell
local -A command

if ! mycmd:command.get_command "${fully_qualified_name}" command; then
    mycmd.log "Unknown command: '${fully_qualified_name}'."
    return 1
fi

mycmd:command.print_version command
mycmd.output ""
mycmd:command.print_short_description command
mycmd.output ""
mycmd:command.print_help_text command
```

To break it down, first, I declare a local associative array variable `command`:

```shell
local -A command
```

Then, I call the function to populate that array variable with the instance referred to by the id in the `fully_qualified_name` variable, passing the `command` variable by name:

```shell
mycmd:command.get_command "${fully_qualified_name}" command
```

And then I call methods on that instance, by explicitly passing the instance to the function, again by name:

```shell
mycmd:command.print_version command
```

This helps me emulate the good parts of OOP.

I intend on diving deeper into this topic in a separate development log entry, and when I do, I will update this post with a link to that one.

## Tangent Over: What I've Implemented in `mycmd-command-group-lib`

Okay, with that description out of the way, here's what I realized. In [mycmd-command-group-lib](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-group-lib), the way things are currently named, it was as if it were just the Command Group object. But, in fact, I have two different "objects" here: the Command Group and the Command Group Registry. I have a similar dichotomy in [mycmd-command-lib](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-command-lib), where the Command "object" is implemented.

I am still thinking about the naming, I'm not sure if "Registry" is the best term here. However, I do realize it is a separate entity. I think this distinction will help me. The way I have split up the code for [mycmd-lib](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-lib) and its supporting libraries is by putting independent code in its own file, so it can be as independently tested as possible. To avoid circular dependencies between the `mycmd-command-lib` and `mycmd-command-group-lib`, I have put code for [discovering command groups and commands](https://github.com/travisbhartwell/mycmd/blob/7777d95d1077b8f5864ca247ca188a93383c29c7/mycmd/mycmd-lib#L51-L92) in the top-level `mycmd-lib`. However, if I move the registry code for each of these in separate files, I might be able to better separate this out.

I have a lot of thinking to do in order to make this work out right. I appreciate the level of thinking that sitting down and trying to document things, along with writing tools to understand my code, and how it enables me to eventually create better software.

## Summary

I got a later start today, so I really didn't have any code changes today. Most of my December Adventure was actually writing this entry. However, I feel like I made a breakthrough in understanding how to clean up my code and make it easier to maintain and test in the future, so I call today a win.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
