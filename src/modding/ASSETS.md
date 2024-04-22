# Asset Loading

Assets are loaded mostly the same with ToppinLoader, though the path to the assets are defined automatically instead of making users put the mod folder at a specific path.

```gml
// Look ma, I'm loading my assets!
var assetpath = mod_dir + "assets/";
mu_lap3 = audio_create_stream(assetpath + "mu_lap3.ogg");
```

This will load `assets/mu_lap3.ogg` and store a stream id for use with audio functions relative to the path of the location of the mod's ini file.