# December Adventure 2024: Day 9

## MyCmd: Unifying Command Group and Command Registries

Software design is messy; especially if you are working with a language constrained in its semantic toolset like Bash.

A thought occurs to me that I need to ponder: could I merge the command group and command registries into a singular concept? I think this might be worthwhile, as it would make command line parsing trivial. Maybe.

I think this is best described by looking at the scalar fields of each object. Here I'm linking to an older commit when the field names were all together for easy reference.

In a [Command Group](https://github.com/travisbhartwell/mycmd/blob/934df52f64349474cf8ec19fe56d96290eb08451/mycmd/mycmd-command-group-lib#L92-L100), we have:

* a name
* a fully-qualified name
* a source directory
* a source file path
* a short description
* a long description
* a version
* whether or not metadata has been loaded

In a [Command](https://github.com/travisbhartwell/mycmd/blob/934df52f64349474cf8ec19fe56d96290eb08451/mycmd/mycmd-command-lib#L77-L84), we have:

* a name
* a fully-qualified name
* a source file path
* a short description
* help text
* a version
* whether or not metadata has been loaded

The only differences: 

* A command doesn't have an explicit source directory, but it is implicit. A command group just explicitly uses it for discovery of child commands and command groups.
* What I call "long description" in a Command Group is "help text" in a Command. They are essentially the same thing and I am considering unifying them both to help text.

In other words, the core data structures are the same. The differences are within the operations defined on them.

## MyCmd: A Virtual File System

When I was on my afternoon walk, I had the realization that what I'm implementing is essentially a virtual file system (VFS). Here's what MyCmd does:

* Implements a hierarchy of things indexed.
* Each of those items indexed have names and are referred to by fully-qualified paths.
* In that hierarchy, two things are indexed:
  * Leaf-node objects -- these are the commands.
  * Container objects, that can contain other containers or leaf-node objects -- these are the command groups.
* Using the [MyCmd Search Path](https://github.com/travisbhartwell/mycmd/blob/8a4986081122a7eae06c2a8e363e57b6cde8b517/docs/mycmd-path.org), it defines different locations on the host filesystem that map to the same fully qualified paths in the index. This is similar to the overlay filesystem used by a Docker container.

And if we look at the implementation of Unix-like filesystems, what is the core data structure? The index node, or [inode](https://en.wikipedia.org/wiki/Inode). At a great simplification (and perhaps over-generalization), every file and directory on disk has an inode. It is the data common to both.

I'm not sure if registry is the right word now for this concept; though filesystem or VFS isn't quite accurate either, as that is too low level. But using registry for now, I think this is what I want to implement:

* There will be a global MyCmd registry that is similar to the Command Group specific one I implemented in [yesterday's work](../2024-12-08-december-adventure-2024:-day-8/#mycmd-cleaning-up-the-command-group-code), with a set of global associative arrays.
* There will be a common Indexed Item (my version of an inode) data structure used for instances of command groups and commands. The common accessor functions will be implemented for this object.
* The Indexed Item will have an additional field indicating if it is a command group or command.
* The differentiating features will be implemented with functions specific to command groups and commands, using the `mycmd:command_group` and `mycmd:command` prefixes.

## Summary

I didn't write any code today. I spent most of my day pondering these ideas. I'm still not all the way decided if this is the best way to go. It will enable me to factor the common code from the two current largest files into a common one, as well as give me a place for some common code I was putting in the top-level `mycmd-lib` file. Plus, when I finish my clean-ups and get to implementing command-line parsing for the MyCmd launcher, having a single data structure holding data for all items will make the querying a lot easier.

## Tomorrow

I'm going to sleep on this idea and if it still feels right, I'll attempt to create the unification of the registry and indexed item tomorrow. Naming things is hard, though.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
