# December Adventure 2024: Day 17

## MyCmd Registry Implementation

I made pretty good progress on the implementation of the MyCmd Registry. However, in the process of doing today's implementation, I had to break some existing tests. I am making enough progress, however, that I will be updating things to get all tests passing again tomorrow. I like what I have written today, as they are a simplification of what I previously had implemented.

* [commit 27a3c13acf9603435a099f28a366256cc3a253f7](https://github.com/travisbhartwell/mycmd/commit/27a3c13acf9603435a099f28a366256cc3a253f7): Loading help information on demand.
* [commit 6098f70f9927e86c4de94222b7292885a95da7cd](https://github.com/travisbhartwell/mycmd/commit/6098f70f9927e86c4de94222b7292885a95da7cd): General loading mechanism for commands and command groups.
* [commit f013c254bbcfa772b79322f9969f91b3f6b6ee29](https://github.com/travisbhartwell/mycmd/commit/f013c254bbcfa772b79322f9969f91b3f6b6ee29): Test the parent command groups array.
* [commit d6b3feac6df14921457670a850001a530e9cb07d](https://github.com/travisbhartwell/mycmd/commit/d6b3feac6df14921457670a850001a530e9cb07d): Rename accessor to `get_parent_command_group_fully_qualified_name`.

I should be able to make decent progress on the integration of this code tomorrow. I should also add documentation comments to [mycmd-registry-lib](https://github.com/travisbhartwell/mycmd/blob/d6b3feac6df14921457670a850001a530e9cb07d/mycmd/mycmd-registry-lib) to document the objects I have implemented and their components. The code for Command Groups and Commands now shares a large common base and their unique code is going to be very small. These efforts have been well worth it.

## My First Entity Component System

Today, on the Nova discord, Arnaldur described an [Entity Component System](https://en.wikipedia.org/wiki/Entity_component_system) as the following:

> The core ideas are certainly very simple.
>
> * Entities are just an index of some type
>
> * Components are collections of homogeneous data that can be indexed by the entity id
>
> * Systems are procedures/functions that operate on every entity that has some set of associated components.
>
> I'm pretty sure there isn't anything more to it in the general sense

It made me realize that what I've been implementing using the [Pseudo-Struct Pattern](../2024-12-07-december-adventure-2024:-day-7/#mycmd-development-pattern-pseudo-structs) and the implementation of the Registry and the common type, Registered Item, for Command Groups and Commands is essentially an ECS using this definition. The entity id that I use is the fully qualified name, such as `mycmd/shell/extended`.

I think I want to read more about how ECS are implemented and used to see if I can find improvements to the pattern in my implementation.

## Cognitohazards, Side Quests, and Shiny Object Syndrome

While walking on the treadmill today, I watched this video, "Tired of Shiny Object Syndrome? Watch This":

<iframe width="560" height="315" src="https://www.youtube.com/embed/WsIHnKph3BE?si=0HuedgBwfitQOVeb" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

Shiny Object Syndrome: getting easily distracted by new ideas, instead of continuing with what you are currently working on.

He has some useful points here, including:
* We should be aware of the sources of the shiny objects, such as social media, and be deliberate at their use.

* We should be aware of the circumstances that lead us to chase shiny objects -- for example, when we are in the midst of the great efforts to finish something else. We may get caught up with a new shiny object, not recognizing that pursuing it will also eventually require great effort as well.

* It is sometimes useful to get these ideas out of mind by writing them down, because perhaps in the future they would be useful again.

* When committing to a project, we should also commit to what we also won't do.

* But we should also be aware of when new ideas come that sometimes there are good ideas that are worth following.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
