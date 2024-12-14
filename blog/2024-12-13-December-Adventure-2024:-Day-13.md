# December Adventure 2024: Day 13

## MyCmd: Meta

I pushed [commit c8945d177d06829da08d080af32417bf4ebede20](https://github.com/travisbhartwell/mycmd/commit/c8945d177d06829da08d080af32417bf4ebede20) that added support for executing [git-quick-stats](https://github.com/git-quick-stats/git-quick-stats).

With it, I was able to get the following statistics for my work on MyCmd:

```
Contribution stats (by author) on the current branch:

         Travis B. Hartwell <nafai@travishartwell.net>:
          insertions:    19652  (100%)
          deletions:     8220   (100%)
          files:         527    (100%)
          commits:       141    (100%)
          lines changed: 27872  (100%)
          first commit:  Sat Aug 28 20:35:08 2021 -0700
          last commit:   Fri Dec 13 17:52:47 2024 -0800

        total:
          insertions:    19652  (100%)
          deletions:     8220   (100%)
          files:         527    (100%)
          commits:       141    (100%)
```

For reference, the current code base is at around 7,500 lines of code, including the `myrpoject` file, the implementation code, and the test code. This does not include a few support scripts in Bash and Python, as well as the documentation I've written.

## MyCmd Registry Implementation

I made incremental progress on the MyCmd Registry implementation. Shout-out to the folks on the Nova Discord for listening to me talk through the challenges I am facing right now. The challenges lie in the fact that this rework to have a registry includes basically combining together almost 1,500 lines of the roughly 5,000 implementation lines. These are not changes that I can make incrementally and start using the new code and have tests pass. I know that I find it easier to focus and establish a rhythm when I can make incremental changes and pass tests, etc.

The compromise I came up with is the following strategy:

* Start at the top level of the MyCmd Registry and work my way down.
* Start a MyCmd test file.
* Avoid hooking up the registry to the rest of the code until the end.
* Copy top-level code into the registry code and associated tests in to the registry test file.
* Break down tasks into incremental steps that involve implementing a function or two and creating a test.

Ultimately, the idea is to give me quick feedback and the ability to make and test incremental changes. I find this works well for me.

I pushed [commit fc917ec3089d9e1ecd74a05f0a8e1ffaab4e1b3a](https://github.com/travisbhartwell/mycmd/commit/fc917ec3089d9e1ecd74a05f0a8e1ffaab4e1b3a) with small changes:

* Added code that I had started yesterday.
* Created a new test file `testing/tests/registry-test` for testing the MyCmd Registry.
* Added some incremental steps broke down to my planning document.
* Fixed one existing test accounting for the new file added.

## The Game Awards

Yesterday was the annual [The Game Awards show](https://thegameawards.com). During the announcement of the winner of the overall game of the year, Swen Vincke, CEO of [Larian Studios](https://larian.com), the makers of the amazing "Baldur's Gate 3", called out the gaming industry. There have been a lot of layoffs, studio closures, and other things in the gaming industry that are obviously completely driven by profit and for the benefit of a few.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Hjcy-VZiQ0w?si=SNPXTccvMll791IX" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

I think what he said holds to the ethos of why I am in tech (even though I no longer work in the game industry):

> It's stupidly simple, but somehow it keeps on getting lost. A studio makes a game because they want to make a game they want to play themselves. They created it because it hadn't been created before. They didn't make it to increase market share. They didn't make it to serve the brand. They didn't have to meet arbitrary sales targets, or fear being laid off if they didn't meet those targets.

> Furthermore, the people in charge forbade them from cramming the game with anything whose only purpose was to increase revenue and didn't serve the game design. They didn't treat their developers like numbers on a spreadsheet. They didn't treat their players as users to exploit. And they didn't make decisions they knew were short-sighted in function of a bonus or policy. They knew that if you put the game and the team first, the revenue will follow. They were driven by idealism, and wanted players to have fun, and they realized that if the developers don't have fun, nobody was going to have any fun. They understood the value of respect, that if they treated their developers and players well, the same developers and players would forgive them when things didn't go as planned. But above all they cared about their games, because they love games. It's really that simple.

Developers are people. The people who use the tools and tech we make are people. We make these tools because they are useful and we have fun doing so. This is the ethos I want to embody. This is the kind of work I want to do. Larian, Swen's studio, embodies this. And they did so while also being immensely successful. (See Wikipedia about the [reception of Baldur's Gate 3](https://en.wikipedia.org/wiki/Baldur%27s_Gate_3#Reception), and the [numerous awards it received](https://en.wikipedia.org/wiki/Baldur%27s_Gate_3#Accolades)).

This also reminds me of a quote from an early computer scientist, [Alan Perlis](https://en.wikipedia.org/wiki/Alan_Perlis). I actually have this quote framed and up on my wall by my desk at home:

> I think that it's extraordinarily important that we in computer science keep fun in computing. When it started out, it was an awful lot of fun. [...] We began to feel as if we really were responsible for the successful, error-free perfect use of these machines. I don't think we are. I think we're responsible for stretching them, setting them off in new directions, and keeping fun in the house. I hope the field of computer science never loses its sense of fun. [...] What you know about computing other people will learn. Don't feel as if the key to successful computing is only in your hands. What's in your hands, I think and hope, is intelligence: the ability to see the machine as more than when you were first led up to it, that you can make it more.

I never want to lose my sense of wonder and fun. Sometimes that capitalist system we live in makes that hard.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
