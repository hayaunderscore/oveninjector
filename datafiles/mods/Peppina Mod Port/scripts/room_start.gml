with (global.pepctop)
{
	if (room_get_name(room) == "tower_finalhallway" && global.panic == 0)
		global.yougotpep = 0;
	if (room_get_name(room) == "tower_5" && global.panic && global.yougotpep == 0)
		visible = 1;
	else
		visible = 0;
}