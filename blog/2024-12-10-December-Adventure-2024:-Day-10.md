# December Adventure 2024: Day 10

## Minor Cognitohazard: VTables and Polymorphism in Bash

Continuing to think about my unification of the central registry of Command Groups and Commands, I realized that there were some actions that were slightly different depending on which item you were operating on.

In a traditional OOP language, these sorts of differences are usually handled with some sort of polymorphism. In many implementations, this polymorphism is handled by a [vtable](https://en.wikipedia.org/wiki/Virtual_method_table). In a language like C++, this table contains function pointers to the code for the implementation that applies for the particular instance of an object.

I created a little experiment to see if it could be done, and I was successful. This is possible because of the way Bash code is executed. (Again, I intend on writing a whole development log entry on this...) My short approximation of how Bash is executed (which may not be 100% true): it evaluates things line by line. For each line, before it executes, it evaluates any variables, executes any calls to subshells (i.e. `$(...)`) and then evaluates the resulting text.

This quality gives us the ability to put the name of a function to be executed in a variable and then just reference that variable to execute it.

Therefore, take a look at [this sample](https://gist.github.com/travisbhartwell/6eec91becd226385947c4fbca786215d). Following my Pseudo-Struct pattern, each object is represented by an associative array. One of the elements of that array is the name of the action function to execute. This section function is the polymorphic part:

```bash
function widget:do_action() {
    local -n widget_struct_ref="${1}"

    local action
    action=$(widget:_get_action "${!widget_struct_ref}")
    readonly action

    "${action}" "${!widget_struct_ref}"
}
```

It first gets the name of the action function from the object's associative array. Then it calls that function, passing along the array reference to the object.

And this code works:

```
>./vtable.sh
Greeting Travis in English:
Hello, Travis!
Greeting Hans auf Deutsch:
Guten tag, Hans!
```

Still thinking about whether this will be a good pattern in practice, but I like that it is possible.

## Meta

I admit, I really dislike my writing voice (if that's the right term). In retrospect, I wish I would have taken communication and writing specifically more seriously in my education and throughout my career. I went through most of my university education in Computer Science with only writing short reports for projects. I think I went several years without having to write any essays. I know that writing is something that takes practice. This is one reason I think December Adventure is good: because each day I am choosing to work on writing some code and then also writing about those projects. This is definitely a practice I want to continue. I want to improve my ability to write. I want to learn how to get drafts out and then edit my writing to improve the writing. I want to work on more long-form content.

I had a really low energy day, so I only got my little experiment above done. But I also kept mulling over the next steps and I think I'm getting a more clear picture for when I do dive into coding again, hopefully tomorrow.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
