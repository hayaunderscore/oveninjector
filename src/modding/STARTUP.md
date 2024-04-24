# Startup Mods

Do you want a mod to be enabled immediately after launching the game instead of waiting until you get into the mod menu?
Simply put a `startup.txt` file in your mods folder like so:

```plaintext,filepath=mods/startup.txt
# A comment like this is ignored.
// This too.
Lap 3
Some Other Mod
Another Mod
```

This will load Lap 3, Some Other Mod, and Another Mod in that order.
This is based on the folder name of the mod however!
