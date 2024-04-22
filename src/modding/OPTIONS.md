# Mod-Specific Options

You can now make players configure your mods via the `options` key in the `meta` block! Like so:

```toml
[meta]
name="yeah"
options="enable_something,another_toggle"
```

Pressing TAUNT on the mod menu while hovering an active mod will bring up the options related to that mod!

![Look ma, options!](https://github.com/hayaunderscore/oveninjector/assets/126386046/5b7be629-b0d0-4899-92e3-c18b2c07d2d1)

Options have a default value of zero, though these can be changed via the `options` block:

```toml
[options]
enable_something="1"
```

`enable_something` will now be "ON" by default.

You can access these via referencing the option name in your scripts.

```gml
if enable_something
    yeah();
else
    nah();
```

If the option `enable_something` is on, it'll call `yeah()` here, and if it's off, it will run `nah()` instead.

Do note that this is NOT a global constant yet, and therefore is specified in the custom controller itself, so to access it within a `with` block be sure to prefix it with `other`.

```gml
with (obj_player)
{
    // This will error!
    if enable_something { }
    // This won't 
    if other.enable_something { }
}
```