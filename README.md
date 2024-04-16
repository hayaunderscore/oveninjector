# OvenInjector
- A decompilation mod for Pizza Tower v1.1.0 (Noise Update)
- A modloader in it's purest form.

# Requirements
- [Pizza Tower on Steam](https://store.steampowered.com/app/2231450/Pizza_Tower/)
- [GameMaker LTS 2022](https://gms.yoyogames.com/GameMaker-Installer-2022.0.1.31.exe) w/ Runtime 2022.0.1.30 <br/>
This seems to be the exact version Tour De Pizza used. 2023.6 might work though I have not tested it yet
- [GMLive.gml](https://yellowafterlife.itch.io/gamemaker-live) <br/>
The repo does not provide GMLive as-is due to the extension being a paid product.

This repository doesn't include any of the datafiles (FMOD, langs) or sprites. An [UndertaleModTool](https://github.com/krzys-h/UndertaleModTool/releases) script is included to extract everything needed from the `data.win`, and port the required files to the decomp folder.

# The Script

1. Make sure Pizza Tower is up to date, and open its `data.win` file in UndertaleModTool. Open the "Scripts" tab at the top of the window, and select "Run other script..."

<img src="github/guide1.png">

2. Go to the decomp's folder, and select the `PTdecompiler.csx` file.

<img src="github/guide2.png">

3. The script will ask you to select a folder. Select the decomp folder.

<img src="github/guide3.png">

4. It takes a while to dump every frame of every sprite. Give it about 15 minutes... Make sure it dumps this to the same folder the YYP file is located.
5. Run the `PizzaTower_GM2.yyp` in the *right version of GameMaker*. Import your GMLive package and add all contents of the extension. You should now be able to compile.

# mod.ini Specification

The mod uses a folder structure to sort out mods. Each folder contains a `mod.ini` that contains metadata about the mod, like it's name and description. **Atleast a name is required. This will be the mod's identifier when you interop with other mods.**

A `mod.ini` file can contain the following information:

```
[meta]
name="Mod Name"
description="Basic description"
author="Author 1, Author 2"
version="1.0"
icon="assets/icon.png"
```

If no mod icon is specified, it simply shows the default icon on the mod menu instead. If you don't want to store the mod icon as an asset, you can also use `icon_base64` to store it as a base 64 encoded string.
