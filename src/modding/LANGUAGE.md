# Language Definitions

**This is not implemented yet, though boilerplate has been added to account for this in the future!**

Fun fact: OvenInjector does not touch any of the other files apart from your `data.win`. The mod loader includes it's own localization file named `custom.txt` located in your mod folder.
This file handles all of the language definitions exclusive to the mod (such as the name for the mod menu in the options and the shoot key).
Mods can also have their own individual language definitions as well.

```plaintext,nolang,filepath=lang/english.txt
# Removing this file may result in crashes.
# This is required, as this is based on the current language selected.
lang = "en"

# Put all your stuff here.
lang_name_here = "STRING BOYS"
```

```gml,filepath=scripts/init.gml
trace(lang_get_value("lang_name_here"));
```

Both of these files would be located in your mod folder, as per usual.
This would've printed a language definition named `lang_name_here`, defined in the language file.