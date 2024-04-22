# mod.ini

OvenInjector uses a `mod.ini` to differentiate and identify mods.

Let's just say there's a mod folder

```ignore,nolang
mods/
```

next, we add a new folder that will hold all of the script and asset files of our mod

```ignore,nolang
mods/
- Sample Mod/
```

with this, a `mod.ini` file is required, which contains all the information needed for a mod to work.

```ini,filepath=mod.ini
[meta]
name="Sample Mod"
description="An example mod."
author="haya3218"
version="1.0"
icon="path/to/your/icon.png"
icon_base64="this can also be used if you want your icon to be b64 encoded instead, CST1229 TL mod loader style!"
```

The `meta` block defines metadata and general info about the mod. An optional `gml` block can also be added, if you want your gml scripts properly named.

The `gml` block takes numerous event callbacks. Which are:

```ignore,nolang
init
destroy
begin_step
step
end_step
begin_draw
draw
end_draw
begin_draw_gui
draw_gui
end_draw_gui
room_start
room_end
```

By default, the game would look for these names plus the gml extension on the scripts folder for these events, except for the `gui` events. The `draw_` part is ommited from those.

Now the general structure should now look like this:

```ignore,nolang
mods/
- Sample Mod/
  - scripts/
    - init.gml
    - step.gml
  - mod.ini
```

Organized as it probably should. Hopefully.