# Installation

There are multiple ways to install OvenInjector. You can either download it from the GameBanana page or compile it manually.

## GameBanana

OvenInjector is distributed in [GameBanana](https://gamebanana.com/wips/84115). 
This is the recommended way to install the mod.

The archive includes the `xdelta` patch for you to patch via [Delta Patcher](https://github.com/marco-calautti/DeltaPatcher/releases) or any other `xdelta` patcher.
**Pizza Oven is broken currently and cannot patch this properly.** Please use Delta Patcher to patch your `data.win`.

## Compile via GameMaker

Compiling via GameMaker is also an option, though you will need these in order to compile it properly:
    
- [Pizza Tower on Steam](https://store.steampowered.com/app/2231450/Pizza_Tower/)
- [GameMaker LTS 2022](https://gms.yoyogames.com/GameMaker-Installer-2022.0.1.31.exe) w/ Runtime 2022.0.1.30 <br/>
This seems to be the exact version Tour De Pizza used. 2023.6 might work, though I have not tested it yet.
- [GMLive.gml](https://yellowafterlife.itch.io/gamemaker-live) <br/>
The repo does not provide GMLive as-is due to the extension being a paid product.

The source code doesn't include any of the datafiles (FMOD, langs) or sprites. An [UndertaleModTool](https://github.com/krzys-h/UndertaleModTool/releases) script is included to extract everything needed from the `data.win`, and port the required files to the decomp folder.

Open up your Pizza Tower `data.win` on UndertaleModTool, open up the `Scripts` tab at the top of the window, and select "Run other script..."

Select PTdecompiler.csx from where you stored OvenInjector's source code. Make sure you point it in the same exact folder when prompted to. It may take a while to extract every sprite, so give it atleast 15 minutes.

Open up `PizzaTower_GM2.yyp` in GameMaker LTS 2022. (*this is important!*) The project won't compile due to GMLive being missing.

Click on the "Tools" tab on the top of the GameMaker IDE, and select "Import Local Package". Select GMLive's `.yymps` file, and import all assets.

You should now be able to run the game via F7. Give it atleast 20 minutes.