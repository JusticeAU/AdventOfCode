/// @description 
numberStrings = [];

function load_input_day_18(_path)
{
	var _file = file_text_open_read(_path);
	
	for (var i = 0; !file_text_eof(_file); i++)
	{
		var _line = file_text_read_string(_file);
		array_push(numberStrings, _line);
		file_text_readln(_file);
	}
}

function add_numbers(_index1, _index2)
{
	numbers[_index2] = "[" + numbers[_index1] + "," + numbers[_index2] + "]";
}

function reduce_number(_string)
{
	var reduced = false;
	var tooDeep = find_deep_pos(_string);
	if (tooDeep != -4) _string = explode(_string, tooDeep);
	return _string;
}

function find_deep_pos(_string)
{
	var _depth = 0;
	var _depth_max = 5;
	for (var i = 1; i <= string_length(_string); i++)
	{
		switch(string_char_at(_string, i))
		{
			case "[":
				_depth += 1;
				if (_depth == _depth_max) return i;
				break;
				
			case "]":
				_depth -= 1;
				break;
			
			default:
				break;
		}
	}
	
	//nothing is nested too deep
	return -4;
}

function explode(_string, _pair_index)
{
	//get the pair values
	var num1 = real(string_char_at(_string, _pair_index+1));
	var num2 = real(string_char_at(_string, _pair_index+3));
	//replace pair with a zero.
	_string = string_delete(_string, _pair_index, 5);
	_string = string_insert(0, _string, _pair_index);
	//add num 2 to right number
		//get right number
		var rhs = get_right_num(_string, _pair_index+1);
		if (rhs[1] != -4) //there might not be a rightmost number.
		{	// delete it from ther string, add the numbers, insert the new number.
			_string = string_delete(_string, rhs[1], 1);
			rhs[0] = num2+rhs[0];
			_string = string_insert(rhs[0], _string, rhs[1]);
		}
	// do left
		var lhs = get_left_num(_string, _pair_index);
		if (lhs[1] != -4)
		{
			_string = string_delete(_string, lhs[1], 1);
			lhs[0] = num1+lhs[0];
			_string = string_insert(lhs[0], _string, lhs[1]);
		}
	return _string;
}

function get_right_num(_string, _index)
{
	
	for (var i = _index+1; i <= string_length(_string); i++)
	{
		var _char = string_char_at(_string, i);
		var _num = -4;
		if (string_length(string_digits(_char)) > 0) _num = string_digits(_char);
		if (_num >= 0) return [_num, i];
	}
	return [-4,-4];
}

function get_left_num(_string, _index)
{
	
	for (var i = _index-1; i > 0; i--)
	{
		var _char = string_char_at(_string, i);
		var _num = -4;
		if (string_length(string_digits(_char)) > 0) _num = string_digits(_char);
		if (_num >= 0) return [_num, i];
	}
	return [-4,-4];
}