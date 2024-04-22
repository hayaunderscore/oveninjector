# Music Handling

Music is a pain. 
Namely FMOD is still unavailable during this time (which might change...) but music isn't too much of a hassle unless you REALLY want to change a lot. 
If so, use a custom controller instead.

## GameMaker Audio System

Custom music can be handled via `scr_play_external_music(path)` and `scr_stop_external_music()`, which play and stop external music respectively. These also account for your volume config as well as the pause menu. Do note that `scr_play_external_music` will ALWAYS stop the current running FMOD music, though this may change.

You can also instance `obj_musiccontroller` yourself, though I don't recommend it. Just use `obj_customcontroller` instead.

## FMOD

TBD.