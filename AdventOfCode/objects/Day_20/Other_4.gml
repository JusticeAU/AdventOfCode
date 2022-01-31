/// @description 
load_input_day_20("C:\\dev\\AdventOfCode\\day20.txt");
var enhancement = 0;
repeat(50)
{
	image[enhancement+1] = EnhanceImage(image[enhancement]);
	enhancement++;
	show_debug_message(enhancement);
}

var _count = CountLit(image[2]);
show_debug_message("Part 1: " + string(_count));
var _count = CountLit(image[50]);
show_debug_message("Part 2: " + string(_count));