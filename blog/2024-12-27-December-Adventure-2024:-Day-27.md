# December Adventure 2024: Day 27

## MyProject

I have settled on the name MyProject for the MyCmd Project Task Runner for now.

Today I spent some time writing as a follow up to what I wrote yesterday to figure out the remaining design areas that I have to figure out before starting to implement.

I realized that there are some things I don't think I can decide on until I start implementing and using the new project. A lot of the unknowns are around how to handle code reuse and how much of the MyCmd Search Path to rely upon for that mechanism. I don't want to implement a package manager, so I am treading carefully.

But I also realize that a big part of the tasks that I have implemented specifically for MyCmd are going to be shared between MyCmd and MyProject, and so inter-project reuse will be at the forefront.

I want to use running code to be my design mechanism. Write down the principles and decisions I have made in design documents, even if these are the decisions "for now". I want to be explicit in writing about my decisions, and more than anything as time goes on, I want to write what I am not building. What features I don't want. What decisions I am making that preclude alternate choices.

I just hope that it won't take me a long time to get to where I want to be. My initial implementation of MyProject only took a few weeks after work earlier this year. And it was the first place I used some of the patterns that are now well-established in the MyCmd code base. Saying, then, that this new implementation will hopefully be quicker and I can get a prototype of the new interface done quickly and then iterate to figure out what I want. I have 15 local projects to migrate over that will serve as good test beds to verify my new design is working and makes sense.

I mainly did some writing today, so not a lot to report. I did start the [MyProject git repository](https://github.com/travisbhartwell/myproject) with an [initial commit](https://github.com/travisbhartwell/myproject/commit/89f3df794ba9dc0b45b0b0e67934d90da67d9be0). Tomorrow I will continue to flesh out the skeleton of the project to start building it up.

I want to continue the work pattern that I've had of writing out tasks and documentation, building a feature, and writing tests for it. I know that it will take a bit of work to get to having tests that can be executed, but that's okay. The important part is I am making enough progress to make the project useful.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
