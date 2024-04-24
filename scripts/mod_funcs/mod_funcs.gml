function live_trace()
{
	var _string = "";
	for (var i = 0; i < argument_count; i++)
		_string += string(argument[i]);
	show_debug_message(_string);
	if instance_exists(obj_shell)
		array_push(obj_shell.output, _string);
}

function live_game_end()
{
	show_debug_message("A mod has attempted to quit the game!");
	if instance_exists(obj_shell)
		array_push(obj_shell.output, "Trying to quit the game eh?");
}