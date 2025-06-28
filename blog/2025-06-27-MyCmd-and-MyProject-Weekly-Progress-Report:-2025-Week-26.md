# MyCmd and MyProject Weekly Progress Report: 2025 Week 26

## MyProject Demo

My demoable goal for this week was to improve the code coverage instrumentation, report generation, and improve the code coverage of my tests.

I wanted to show off the build process for MyProject, and so I made this demo with [VHS](https://github.com/charmbracelet/vhs):

<video controls="controls" width="1200">
    <source src="../../images/project-run-all.mp4">
</video>

This shows executing the build which does:

- formatting all code
- linting all code
- executing all tests
- reporting on test coverage and test results

And then I execute the task to view the code coverage reports.

I am now at ~97% code coverage, the last bit of code not covered will require some changes that I need to make to MyCmd itself to make testing against calls to `mycmd.output` easier. I will do that later.

## This Week's MyProject Updates

This week I pushed [8 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-06-22&until=2025-06-27) to the MyProject repository, including the following changes:

- Rewriting the Code Coverage analysis to rely on tools like `grep`, `sed`, `sort`, and `uniq`; it now executes nearly instantly instead of 21 seconds.
- Generating a summary of code coverage at the end of test execution.
- Updating the vendored version of [shunit](https://github.com/kward/shunit2/) to the latest from the `master` branch.
- Updating the coverage reporting:
  - Allow skipping lines for code coverage by adding a comment: `# coverage skip: 2`, which indicates the next two lines should be ignored for coverage.
  - Handle multi-line statements properly and propagate the coverage to all lines.
- Improved the test coverage.
- Adding new project tasks for paging coverage reports and generating demos using [VHS](https://github.com/charmbracelet/vhs).

## LinkedIn Messages

I was needing to review my old LinkedIn messages this week and I admit I find using the LinkedIn Website and Mobile App a bit frustrating for messages. I Had recently downloaded my full LinkedIn data which includes as CSV file for the messages. This week I put together something to take that CSV file and generate an HTML for each LinkedIn message folder, which then has a link to an HTML file for each conversation. It has made things a lot easier to review these old messages.

See the scripts and details in [this gist](https://gist.github.com/travisbhartwell/e8d3815f4fb716111ba76acfd81bcc05).

That said, I am looking for a new job right now; please reach out with my contact information on my [website](https://iam.travishartwell.net/); see my latest [resume here](https://iam.travishartwell.net/resume/resume.pdf).

## Next Week

I started working on fileset support this week but haven't yet made any commits. I will finish this work

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

