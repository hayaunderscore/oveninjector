Basically, ToppinLoader with a smidge of salt.

This includes an explanation of what it is, as well as some other questions.

If you want to skip all these and just get info on how to load mods, well skip over to "Ok you gave me the nerd stuff how can i load mods".

[TOC]
## Why?

xdelta mods are extremely powerful, though you can't add multiple mods at once. ToppinLoader mods circumvent these, but has limited support, and it's discontinued.

So why not have something in-between?

This is not designed to replace xdelta mods. Directly modified data.win files have more possibilities compared to this modloader. This is only an option for those looking for a simple solution to have multiple mods without doing data.win surgery.

## How?

The mod uses a decompilation of the game by loypoll named OpenTower (unfortunately), which all of you may already know. The mod utilizes the Snippet API of GMLive, a GameMaker extension that enables live coding, as in, you don't have to recompile after changing a snippet of code.

The Snippet API provides ways to load (and execute!) gml code from a string, basically unlocking unrestricted script access to the game. This is mostly perfect for modding, though room edits are gonna be a hassle to do here unfortunately (just use CYOP for that....) GameMaker already provides various functions to load external data files like sprites and music, and the ability to run gml files from disk GM8.1 style makes this even more plausible.

## Isn't this just ToppinLoader?

It uses the same Snippet API that ToppinLoader uses, though the way scripts are loaded is different.

Namely, this uses ini files to differentiate mods between each other, and make sure that each mod doesn't completely conflict with one another all the time.

## Can I implement it in my own decomp mod?

You can do whatever you want with the code as you wish, so long as you give some kind of credit somewhere and follow the LICENSE.