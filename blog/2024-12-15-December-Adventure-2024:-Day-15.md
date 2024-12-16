# December Adventure 2024: Day 15

## MyCmd Registry Implementation

Made a decent amount of progress on the MyCmd registry implementation. Last night I wrote out incremental steps to do today and they ended up being pretty straight forward.


* [commit d1cbba539e9fe512ee9d2299200701920bb6e490](https://github.com/travisbhartwell/mycmd/commit/d1cbba539e9fe512ee9d2299200701920bb6e490): Small cleanups from yesterday.
* [commit 9f205b76975ca0df7352348ec439f2a7038a728f](https://github.com/travisbhartwell/mycmd/commit/9f205b76975ca0df7352348ec439f2a7038a728f): Implement `mycmd:registry._register_command_group`.
* [commit adcc2b3dd261b919558db95e6259520a848ad9c8](https://github.com/travisbhartwell/mycmd/commit/adcc2b3dd261b919558db95e6259520a848ad9c8): Implement item getters and accessors for basic data items.
* [commit d2f0c1cbc2af6a50962e3a162de92ed30c080a51](https://github.com/travisbhartwell/mycmd/commit/d2f0c1cbc2af6a50962e3a162de92ed30c080a51): Use aliases for accessors.

I'm particularly happy with the last commit. Since I had a base `mycmd:registered_item` that implemented functions for the data accessors for Command Groups and Commands. However, I wanted the functions to reflect the actual item type. I did a small test if I could use aliases, which I was able to do so.

---

All of my December Adventure 2024 posts will be linked from [here](../../december-adventure-2024).
