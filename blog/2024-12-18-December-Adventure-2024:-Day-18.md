# December Adventure 2024: Day 18

## MyCmd Registry Implementation

I was able to finish the main parts of the MyCmd Registry today.

* [commit 3e95e5cd475e63562c1d58131a30c5618f236d34](https://github.com/travisbhartwell/mycmd/commit/3e95e5cd475e63562c1d58131a30c5618f236d34): Use the registry in the Command Group implementation.
* [commit 9ebb2a7d1c87fb5ea6065df993c8e26a6daae0a9](https://github.com/travisbhartwell/mycmd/commit/9ebb2a7d1c87fb5ea6065df993c8e26a6daae0a9): Use the registry in the Command implementation.
* [commit cdac13d66997a913228abaad2f318b45480de809](https://github.com/travisbhartwell/mycmd/commit/cdac13d66997a913228abaad2f318b45480de809): Initial implementation of Command execution.
* [commit 9a2cb1375564078b50e38d94911f6169f4601615](https://github.com/travisbhartwell/mycmd/commit/9a2cb1375564078b50e38d94911f6169f4601615): Get Command execution working and all tests passing.

I still need to re-implement the help and version information printing functions and support functions for those.

I also need to add documentation comments in `mycmd-registry-lib` to fully document the pattern.

I feel pretty good about this implementation. The common Registered Item (the entity in my ECS) is the implementation for Commands and Command Groups. The loading functions are simpler than my previous implementation and work the same for Commands and Command Groups.

Take a look at [this diff](https://github.com/travisbhartwell/mycmd/compare/196a3c1a28d38428efbd58a114ff4ebb608477c1..9a2cb1375564078b50e38d94911f6169f4601615) comparing when I started doing cleanup of this code to now. There is only a net of 115 lines of code, and I have added more than that in documentation comments and documentation files. Once I re-implement the help functionality, that will probably be a net of a couple hundred lines of code at most.

I'm pretty proud of these changes.

## MyCmd: Miscellaneous

* [commit 9d1e5bf63ec5307294a2a01d6b0b58f7b4e452a7](https://github.com/travisbhartwell/mycmd/commit/9d1e5bf63ec5307294a2a01d6b0b58f7b4e452a7): Updated the planning document.
* [commit e67bfb803eadbcf45ee3042081f988ee7f9c58ac](https://github.com/travisbhartwell/mycmd/commit/e67bfb803eadbcf45ee3042081f988ee7f9c58ac): Cleaned up the naming of functions in `mycmd-environment-lib`.
* [commit a513267131d3f0de38ffa10825d5841d9ab34ee5](https://github.com/travisbhartwell/mycmd/commit/a513267131d3f0de38ffa10825d5841d9ab34ee5): Cleaned up `mycmd-formatted-output-lib`.
* [commit 098fb1edb4455a0eb990e832336f511ae966869a](https://github.com/travisbhartwell/mycmd/commit/098fb1edb4455a0eb990e832336f511ae966869a): Cleaned up `mycmd-pathname-lib`.

These clean up tasks took less time than I thought it would be. Next steps are going to be re-implementing the MyCmd launcher code in

## MyCmd Launcher Implementation

I started working on the MyCmd Launcher again.

* [commit ba54b819ef1a220a0999fee00b5fc54525f79d8d](https://github.com/travisbhartwell/mycmd/commit/ba54b819ef1a220a0999fee00b5fc54525f79d8d): Add support for executing a command using MyCmd in the shebang line.

My next steps are re-implementing full command-line parsing and dispatch in the launcher.

## Dot Files

I also pushed [commit c23c291b56d68312a8a1ab44b357b2cb9062d037](https://github.com/travisbhartwell/dotfiles/commit/c23c291b56d68312a8a1ab44b357b2cb9062d037) to update my personal MyCmd Command Groups and Commands to temporarily support the older MyCmd versions and my latest changes, so I can actively test my current MyCmd implementation with those scripts as well.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
