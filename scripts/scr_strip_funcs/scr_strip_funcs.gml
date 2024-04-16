// Latest GMLive does not allow multiline strings to work for some reason
// So here's a bandaid fix for that
function scr_strip_funcs(code)
{
	// Find the first "@'"
	while (string_pos("@'", code) > 0)
	{
		trace("Attempting to replace multi-line string...");
		// Find the position of these
		var atpos = string_pos("@'", code);
		var endpos = string_pos("')", code);
		// grab the whole multiline string
		var str = string_copy(code, atpos, endpos - atpos + 1);
		// trim out the "@"
		var new_str = string_replace_all(string_trim(str, ["@"]), "\r\n", "");
		// sneaky fuck
		new_str = string_replace_all(new_str, "\n", "");
		new_str = string_replace_all(new_str, "\t", "");
		// replace all '' with "" and replace all existing "" with \"\"
		// get my drift?
		new_str = string_replace_all(new_str, "\"", "\\" + chr(34));
		new_str = string_replace_all(new_str, "'", "\"");
		// replace the old substring with the new one
		code = string_replace(code, str, new_str);
		trace("Old multiline string: " + str);
		trace("Final multiline string: " + new_str);
		trace("Final string: " + code);
	}
	
	return code;
}
