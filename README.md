# MyCmd

Tool for writing and running commands from a command directory

## Inspiration and Similar Projects

* After reading Ian Henry's post, [sd: my script directory](https://ianthehenry.com/posts/sd-my-script-directory/), and realizing the haphazard way I was throwing together scripts at work, I saw that a similar approach could work for me, giving me reuse for common tasks. It has indeed made my life a lot better. My `mycmd` user directory at work now has over 30 scripts spread across over 15 command groups, and it's infinitely easier for me to create one-off scripts that re-use existing functionality from my other commands and command groups.

## License

MyCmd is licensed under the [MIT license](LICENSE.md) and includes other open source software developed by contributors to their respective projects.

These other libraries included in the `vendor` subdirectory have their own licenses, acknowledged here:
* `bashup.events`: Licensed under the [CC0 License](https://creativecommons.org/publicdomain/zero/1.0/). The project repository is at <https://github.com/bashup/events/tree/bash44>.
* `ansi`: Licensed under the [MIT License with a non-advertising clause](https://github.com/fidian/ansi/blob/master/LICENSE.md). The project repository is at <https://github.com/fidian/ansi>.

Additionally, these libraries used for testing MyCmd included in the `testing/vendor` subdirectory have their own licenses, acknowledged here:
* `shunit2`: Licensed under the [Apache License 2.0](https://github.com/kward/shunit2/blob/master/LICENSE). The project repository is at <https://github.com/kward/shunit2>.
