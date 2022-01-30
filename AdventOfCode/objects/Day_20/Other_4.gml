/// @description 
load_input_day_20("C:\\dev\\AdventOfCode\\day20.txt");
var enhancment = 0;
repeat(50)
{
	image[enhancment+1] = EnhanceImage(image[enhancment]);
	enhancment++;
	show_debug_message(enhancment);
}

var _count = CountLit(image[2]);
show_debug_message("Part 1: " + string(_count));
var _count = CountLit(image[50]);
show_debug_message("Part 2: " + string(_count));
