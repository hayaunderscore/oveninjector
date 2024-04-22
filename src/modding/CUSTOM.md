# Custom Controllers

Each mod works with a custom object (or controller) that runs the compiled gml files at runtime. This is akin to running gml code via `obj_custom` on ToppinLoader, though this is done by the mod loader itself instead of by you.

You can still create new custom controller objects, though be wary of making them persistent and have a `modname` variable, which is the `name` value of your `mod.ini`'s `meta` block. You can access the base object controller's modname via simply referencing the `modname` variable on it's own.

```gml
// Insert cool stuff here
with (instance_create(0, 0, obj_customcontroller))
{
    // custom object is now persistent, meaning it'll stay regardless of being in a new room or not.
    persistent = true;
    // best to pass in the base script's modname for referencing it when the mod is disabled
    modname = other.modname;
    // This custom controller will run even when paused.
    runPaused = true;
    // If you don't want to man handle the object created on different step files, you can also manually create gml snippets here as well!
    events.step = live_snippet_create(@'
        trace("Hello!");
    ');
}
```

**The stuff below has not been implemented yet!**

You can also use `instance_custom(x, y, name)` to easily instance a new persistent custom controller object, that runs it's scripts based on a subdirectory in the scripts folder.

```gml,filepath=scripts/init.gml
instance_custom(0, 0, "ctopPeppino");
```

```gml,filepath=scripts/ctopPeppino/init.gml
sprite_index = spr_player_idle
x = 1999
y = 200
```

Upon loading the mod, the game immediately creates a new custom controller and loads it's init script on the `ctopPeppino` folder, and runs the init script from within that custom controller's context.