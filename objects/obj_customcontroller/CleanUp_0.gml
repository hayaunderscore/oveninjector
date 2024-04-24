if events.destroy != undefined
	live_snippet_call(events.destroy);
// clear all event snippets
// to prevent memory leaks
var keys = variable_struct_get_names(events);
for (var i = array_length(keys) - 1; i >= 0; --i) {
	var k = keys[i];
	show_debug_message("Destroying event: " + k);
	// destroy all one by one
	var snippet = events[$ k];
	if snippet != undefined
		live_snippet_destroy(snippet);
}