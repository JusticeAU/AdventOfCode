/// @description 
for (var _y = 0; _y < array_length(input); _y++){
			for (var _x = 0; _x < array_length(input[_y]); _x++){
				draw_text(_x*15,_y*20, input[_y][_x][0]);
			}
		}