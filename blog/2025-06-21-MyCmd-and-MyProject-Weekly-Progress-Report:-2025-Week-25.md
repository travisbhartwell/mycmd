# MyCmd and MyProject Weekly Progress Report: 2025 Week 25

## MyProject Demo

Last week, I recognized I wanted to improve my testing of MyProject. Even though code coverage as a measurement isn't a good measure of code quality and test fitness on its own, it is an important start.

I had some ideas of how I could instrument my tests, building on the ideas I have written on previously a [shell script profiling](../2024-12-05-december-adventure-2024:-day-5/#cognitohazards-and-side-quests-shell-script-profiling). I can now run my tests and get the following, which produces coverage-annotated source, highlighting missed lines:

![Viewing Coverage Annotated Source](../../images/code-coverage.png)

With the work I did this week, I was able to instrument my tests and then generate `.coverage` files, that show the project source, with each line annotated with the following:

- The number of times the line was executed
- A `-`, if the line was not executed
- A blank space ` `, if the line was blank or was the end of a compound statement (`fi`, `else`, `done`, `esac`, or `}`)
- A `#`, if the line contained only a comment
- an `F`, if the code is the start of a function declaration

The output isn't perfect, for example, if a single statement is split across multiple lines (with lines ending in `\`), only one of the lines is shown as being executed. I think I can improve my code coverage analysis implementation in the future to handle this.

To see the full coverage report from my current code, see [this gist](https://gist.github.com/travisbhartwell/2134385e45192eb695369597f93167dd).

## This Week's MyProject Updates

I pushed [7 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-06-15&until=2025-06-21) this week.

- Refactor my test output to write to a test output directory per test run
- Refactoring my tests to have a shared [test support library](https://github.com/travisbhartwell/myproject/blob/3912ada3dfb334159cf0155732ec2bdc7f677728/testing/tests/testing-support-lib) that handles common setup and cleanup tasks, including setting up tracing used for code coverage.
- Refactoring my test suites into [feature-based](https://github.com/travisbhartwell/myproject/tree/3912ada3dfb334159cf0155732ec2bdc7f677728/testing/tests).
- Implemented project task functions to process and generate code coverage reports, found [here](https://github.com/travisbhartwell/myproject/blob/3912ada3dfb334159cf0155732ec2bdc7f677728/myproject-tasks#L158-L241).

## Next Week

With my code coverage reports, I now know where my test coverage is lacking. I've made some notes on what changes I want to make. So I am going to try doing this next week:

- expand my current test suites to cover cases I am currently missing
- write out plans for testing that I need additional changes to support (I need to make some changes to MyCmd to make testing the output functions like `mycmd.output` easier and also testing MyCmd commands)
- get my planning, design, and concepts and conventions docs up to date
- potential improve the coverage report generator to handle some of the quirks of execution mentioned above

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

