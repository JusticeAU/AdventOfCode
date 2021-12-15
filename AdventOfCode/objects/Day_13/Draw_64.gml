/// @description 
for (var _y = 0; _y < array_length(paper); _y++){
	for (var _x = 0; _x < array_length(paper[_y]); _x++){
		if (paper[_y][_x]){
			draw_set_color(c_white);
		}
		else draw_set_color(c_grey);
		draw_rectangle(0+(_x*5),0+(_y*5),4+(_x*5),4+(_y*5),false);
	}
}