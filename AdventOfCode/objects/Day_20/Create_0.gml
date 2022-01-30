/// @description
viewIndex = 0;

enhancementAlgo = "";
array_size = 110;
image = array_create(1, array_create(array_size, array_create(array_size, ".")));
imageBuffer = 5;

function load_input_day_20(_path)
{
	var file = file_text_open_read(_path);
	
	//read in the enhancement string
	enhancementAlgo = file_text_read_string(file);
	file_text_readln(file);
	file_text_readln(file);
	//read in the grid
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		var _end = string_length(_line);
		for (var charPos = 1; charPos <= _end; charPos++)
		{
			var _char = string_char_at(_line,charPos);
			image[0][i+imageBuffer][charPos-1+imageBuffer] = _char;
		}
		file_text_readln(file); 
	}
	file_text_close(file);
}

function EnhanceImage(_image)
{
	var _imageEnhanced = array_create(array_size, array_create(array_size, "."));
	
	for (var _y = 1; _y < array_length(_image)-1; _y++)
	{
		for (var _x = 1; _x < array_length(_image[1])-1; _x++)
		{
			var _binaryStr = GetBinaryString(_image,_y,_x);
			var _decStr = string_binary_to_decimal(_binaryStr);
			var _enhancedPixel = GetEnhancedPixel(_decStr);
			_imageEnhanced[_y][_x] = _enhancedPixel;
		}
	}
	return _imageEnhanced;
}

function GetBinaryString(_image,_y,_x){
	var _str = "";
	for (var _yy = _y-1; _yy <= _y+1; _yy++)
	{
		for (var _xx = _x-1; _xx <= _x+1; _xx++)
		{
			_bit = _image[_yy][_xx] == "#" ? "1" : "0";
			_str += _bit;
		}
	}
	return _str;
}
	
function string_binary_to_decimal(_string)
{
	var _decimal = 0;
	var _length = string_length(_string);
	for (var i = 1; i <= _length; i++){
		_decimal = _decimal << 1;
		if (string_char_at(_string, i) == "1") _decimal = _decimal | 1;
	}
	return _decimal;
}

function GetEnhancedPixel(_index)
{
	return string_char_at(enhancementAlgo, _index+1);
}

function CountLit(_image)
{
	var _lit = 0;
	for (var _y = 0; _y < array_length(_image); _y++)
	{
		for (var _x = 0; _x < array_length(_image[0]); _x++)
		{
			if(_image[_y][_x] == "#") _lit += 1;
		}
	}
	return _lit;
}