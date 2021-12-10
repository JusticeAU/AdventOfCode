/// @description 
for (var _y = 0; _y < array_length(heightmap); _y++){
	for (var _x = 0; _x < array_length(heightmap[_y]); _x++){
		draw_text(_x*25,_y*25,string(heightmap[_y][_x]));
	}
}