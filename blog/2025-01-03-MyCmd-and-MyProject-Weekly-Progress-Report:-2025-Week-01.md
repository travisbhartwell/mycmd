# MyCmd and MyProject Weekly Progress Report: 2025 Week 01

Since [December Adventure 2024](../2025-01-01-december-adventure-2024:-reflection/) was so successful for me, I have decided to continue my development efforts in the open. To this end, I will be writing a weekly progress update here on my development log on my progress with MyCmd and MyProject. Further, I have decided to adopt a demo-oriented development process, with a demo, however minimal, being my focus for the week.

I also am going to just focus on these projects just during the work week, so I can relax on the weekend. Thus, this week's post is just for the first three days of the year.

## MyProject Demo

My demo-able goal for this week was to implement `mycmd myproject list-tasks` that displays the discovered project root and the associated MyProject Task Definition directory.

![Executing mycmd myproject list-tasks](../../images/mycmd-myproject-list-tasks-minimal.png)

The demo was this simple given that I was starting the project from basically scratch and implementing features I had not yet implemented in my original `mycmd/project` Command Group.

## MyProject Updates

To achieve the above demo, I published [14 commits](https://github.com/travisbhartwell/myproject/commits/main/?since=2025-01-01&until=2025-01-03), following [the design](https://github.com/travisbhartwell/myproject/blob/d3b9a6dcf5c54359301aad30122e833bc93ed9b2/docs/myproject-design.org?plain=1) I had wrote up on the last day of December. I was able to stick with the original design, with just one deviation to change the output of `project.find_up` to be through an array reference passed in instead of something that is output and has to be parsed.

I implemented each step incrementally, only introducing new functions and features as I needed them. With each step, I implemented tests, ending with nearly a 500 line [test file](https://github.com/travisbhartwell/myproject/blob/d3b9a6dcf5c54359301aad30122e833bc93ed9b2/testing/tests/project-lib-test).

## MyCmd Updates

I pushed [two commits](https://github.com/travisbhartwell/mycmd/commits/main/?since=2025-01-01&until=2025-01-03) to MyCmd this week, with one of them being changes in support of the planned work on MyProject. I added support for platform standard user cache and configuration directories. I added functions for Command Groups and Commands to get config or cache files that are scoped to them. I published snapshot [snapshot-r6-2025-01-03](https://github.com/travisbhartwell/mycmd/releases/tag/snapshot-r6-2025-01-03) for use on my local development machine with these changes.

## Next Week

My demo goal for next week is to have `mycmd myproject list-tasks` be able to load and list the tasks from a `myproject/main` file. 

I also am considering on taking some time to figure out if I want to build any mechanisms for testing Commands into the MyCmd core.

---

All of my MyCmd and MyProject Weekly Progress reports will be linked from [here](../../weekly-progress-reports).

