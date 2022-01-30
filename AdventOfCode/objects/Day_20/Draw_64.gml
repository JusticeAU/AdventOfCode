/// @description 
var buffer = 10;
for (var _y = 0; _y < array_length(image[viewIndex]); _y++)
{
	for (var _x = 0; _x < array_length(image[viewIndex][0]); _x++)
	{
			draw_text(_x*buffer,_y*buffer,image[viewIndex][_y][_x]);
	}
}