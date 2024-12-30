# December Adventure 2024: Day 29

## Life Dashboard

I have started putting together what I call a "Life Dashboard" to track important data about my life. Right now, I have data tracking my exercise and my daily dialysis treatments. I have kidney failure and have been doing peritoneal dialysis every night at home for almost 12 years now. I have paper records I use to track my vitals and treatment results for this entire time. To track this data, my current setup is to use a Google Sheets spreadsheet to enter my daily information. I've been able to enter in the last couple years of data, but I need to get the rest of my history entered. I found the tools available to create dashboards with the data views I wanted to be a bit limiting and frustrating, so a couple months ago I went searching for another solution.

I have settled on [Evidence](https://evidence.dev) for my current solution. Compared to similar tools, for me, it has the advantage of allowing me to write Markdown and SQL to generate my dashboards. So, my workflow is this:

1. Enter data in the appropriate Google Sheets spreadsheet.
2. Download a CSV version of the appropriate sheet.
3. Use a Python program I wrote to clean up the data into the format I need.
4. Generate a [DuckDB database](https://duckdb.org/) from that transformed CSV.
5. Import the DuckDB database into my Evidence project.

Of course, this is all tied together with [a MyProject file](https://gist.github.com/travisbhartwell/b63415d0fb0140ebeb3fffb1e524b09c). I'm just linking to a Gist, as the repository that my dashboard data is in is private, since it contains my personal health data.

I write about this because I was a little behind on my data entry and had to catch up today. I have my monthly appointment with my nephrologist (kidney specialist) tomorrow and I want to have my data ready to discuss my status. It's been pretty helpful to take my laptop to my regular appointments and discuss my data.

I have some frustrations and plans that I want to do with my current set up. 

1. Google Sheets really isn't the ideal interface to do bulk data entry. I've long wanted to write a GUI/TUI for data entry for both my phone and laptop but haven't had the energy to do so.
2. While I'm still using Google Sheets, I should set up automation to automatically export the sheets to my Google Drive which will be autosynced to my laptop and could be autoimported into my dashboard.
3. Evidence is easy to get up and going. However, there are some limitations. Since the front-end is all Javascript, the data types they support are limited. For example, one stat that I track from my exercise is my average mile pace while walking in minutes and seconds. Evidence doesn't have a native data type that can represent this and so I haven't been able to figure out a meaningful way to visualize it.
4. I only have basic graphs and statistics set up. I want to add some comparisons (this month compared with last, etc) and trend analysis. My desire is to be able to detect changes in my treatment and otherwise before I or my doctor notice it elsewhere with symptoms.
5. Right now I'm just running the dashboard on my laptop. I really need to get this set up somewhere so it's available generally.
6. I recently bought a [TRMNL device](https://usetrmnl.com) and I want to get something set up to show snapshots of my Life Dashboard data on it.
7. I want to add financial data to this Life Dashboard. I have a decades worth of financial data tracked with [Ledger CLI](https://ledger-cli.org) and I need to write something to export it into a DuckDB in a format that I can create graphs and other visualization for.

## MyProject

I pushed a [small commit](https://github.com/travisbhartwell/myproject/commit/d155997d8b1b03b7b30a2779cea6a830326e69ce) updating my [MyProject planning document](https://github.com/travisbhartwell/myproject/blob/d155997d8b1b03b7b30a2779cea6a830326e69ce/docs/myproject-planning.org?plain=1) and creating placeholder Design and Concepts and Conventions document.

I want to make as quick of progress on the implementation of MyProject as possible, so I am going to use these tenants:

* When I need to figure out something, use Free Writing to figure out the simplest possible thing that could work.
* Document each design decision (even tenuous ones) in the MyProject Design Document.
* When previous decisions end up not working, repeat the process and update the design document.
* When implementing a design, start by breaking down the next steps in small increments in this planning document.
* Implement those design decisions in as small of increments as I can, using automated testing to give feedback, especially when the increment isn't enough to execute meaningfully.
* These small increments can be as small as "create a  placeholder function"; anything to promote momentum.
* Use [demo-driven development](https://mitchellh.com/writing/building-large-technical-projects); iterate quickly towards being able to show the code working.

I've given myself the rest of this week (through Friday the 3rd) to focus solely on MyProject. In the new year I have other things that need to be focused on as well, such as my job search. December Adventure has been great and I want to continue doing development in the open, as it has been entirely motivating and I have made so much progress on my projects.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
