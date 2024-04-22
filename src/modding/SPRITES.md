# Sprite Replacements

**Not implemented yet!**

`sprite_replace()` sucks. We know. You have to manually specify the sprite you want to replace, plus the width and height, as well as the amount of frames. But what if you don't have to do that?

The mod loader can load sprite replacements over at the `assets/replacements/` folder of your mod directory. Simply put, all you need is the sprite name, with the amount of frames appended at the end, so something like `spr_player_idle-4.png`, which will replace `spr_player_idle`, and use 4 frames.

This process is automatic. You don't even need a script for it! You can omit the entire script folder if you'd like! Do note that the game will take a while to replace the sprites, as the game will also cache the original sprite to reload when the mod is disabled (TBD).

You can also go the CYOP route and use a normal ini file with the same file name as the image instead!

```toml
[properties]
images=4
image_width=100

[offset]
centered=1
x=0
y=0
```

This will create a sprite with 4 frames with a width of 100 pixels, centered around the center of the image with no additional offset. `images` and `image_width` are interchangeable! You can have one or the other.