/// @description 
load_input_day_20("C:\\dev\\AdventOfCode\\day20.txt");
var enhancment = 0;
repeat(2)
{
	image[enhancment+1] = EnhanceImage(image[enhancment]);
	enhancment++;
}
var _count = CountLit(image[enhancment])
show_debug_message(_count);

///testing
/*var _binaryStr = GetBinaryString(image[0],7,6);
show_debug_message(_binaryStr);
var _decStr = string_binary_to_decimal(_binaryStr);
show_debug_message(_decStr);
var _enhancedPixel = GetEnhancedPixel(_decStr);
show_debug_message(_enhancedPixel);

