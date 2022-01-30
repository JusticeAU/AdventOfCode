/// @description 
load_input_day_20("C:\\dev\\AdventOfCode\\day20.txt");
var enhancment = 0;
repeat(50)
{
	image[enhancment+1] = EnhanceImage(image[enhancment]);
	enhancment++;
	show_debug_message(enhancment);
}
var _count = CountLit(image[enhancment])
show_debug_message(_count);