# Custom Controllers

Each mod works with a custom object (or controller) that runs the compiled gml files at runtime. This is akin to running gml code via `obj_custom` on ToppinLoader, though this is done by the mod loader itself instead of by you.

You can create new custom controllers via `instance_custom`.

```gml,filepath=scripts/init.gml
// This will load scripts from scripts/obj_gooch
var gooch_id = instance_custom(0, 0, "obj_gooch");
// ... do stuff with gooch_id...
```

```gml,filepath=scripts/obj_gooch.gml
// gooch scout digo real
persistent = false;
sprite_index = spr_pizzaface_haywire;
image_speed = 0.35;
maxspeed = 3;
```

The above example will create a new custom controller running from the `obj_gooch` folder, and is instantiated from the init script.

You can still create new custom controller objects the old way, though be wary of making them persistent and have a `modname` variable, which is the `name` value of your `mod.ini`'s `meta` block. You can access the base object controller's modname via simply referencing the `modname` variable on it's own.

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