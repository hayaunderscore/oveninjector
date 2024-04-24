/// @description Custom object creation

// Reduce redundancy
#macro empty_snip undefined

// identifier for removal
modname = ""
runPaused = false;

// all possible events
events = {
	// destroy event
	destroy: empty_snip,
	// step events
	begin_step: empty_snip,
	step: empty_snip,
	end_step: empty_snip,
	// draw events
	begin_draw: empty_snip,
	draw: empty_snip,
	end_draw: empty_snip,
	// gui events
	begin_gui: empty_snip,
	gui: empty_snip,
	end_gui: empty_snip,
	// room related events
	room_start: empty_snip,
	room_end: empty_snip,
	// http
	http: empty_snip,
}