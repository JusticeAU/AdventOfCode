/// @description 


function load_input_day_18(_path)
{
	numberStrings = [];
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
	return ("[" + numberStrings[_index1] + "," + numberStrings[_index2] + "]");
}

function reduce_number(_string)
{
	var reduced = true;
	do
	{
		reduced = true;
		var _deepest = find_deep_pos(_string);
		
		if (is_array(_deepest))
		{
			reduced = false;
			_string = explode(_string, _deepest);
			//show_debug_message(_string);
			continue;
		}
		else
		{
			var _split = find_split_index(_string);
			if (_split != -4)
			{
				reduced = false;
				_string = split(_string, _split);
				continue;
			}
		}
		
	}
	until (reduced);
	
	return _string;
}

function find_deep_pos(_string)
{
	var _depth = 0;
	var _depth_max = 5;
	
	var _start = -4;
	var _comma = -4;
	var _end = -4;
	
	for (var i = 1; i <= string_length(_string); i++)
	{
		switch(string_char_at(_string, i))
		{
			case "[":
				_depth += 1;
				if (_depth == _depth_max) //found pair that is too deep
				{
					_start = i;
					for (var c = i; c <= string_length(_string); c++) //searching for comma seperator
					{
						var char = string_char_at(_string, c);
						if(char == ",") //found comma
						{
							_comma = c;
							for (var e = c; e <= string_length(_string); e++) // , searching for end of pair
							{
								char = string_char_at(_string, e);
								if (char == "]")
								{
									_end = e;
									return [ _start, _comma, _end ];
								}
								
							}
						}
					}
				}
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

function explode(_string, _pairArray)
{
	
	
	//get the pair values
	//get left and right numbers
	var lhsIndex = _pairArray[0]+1;
	var lhsSize = _pairArray[1]-_pairArray[0]-1;
	var num1 = real(string_copy(_string, lhsIndex, lhsSize));
	var rhsIndex = _pairArray[1]+1;
	var rhsSize = _pairArray[2]-_pairArray[1]-1;
	var num2 = real(string_copy(_string, rhsIndex, rhsSize));
	
	//replace pair with a zero.
	var _pairLength = _pairArray[2]-_pairArray[0]+1;
	_string = string_delete(_string, _pairArray[0], _pairLength);
	_string = string_insert(0, _string, _pairArray[0]);
	//add num 2 to right number
		//get right number
		var rhs = get_right_num(_string, _pairArray[0]+1);
		if (rhs[1] != -4) //there might not be a rightmost number.
		{	// delete it from ther string, add the numbers, insert the new number.
			_string = string_delete(_string, rhs[1], string_length(rhs[0]));
			rhs[0] = num2+rhs[0];
			_string = string_insert(rhs[0], _string, rhs[1]);
		}
	// do left
		var lhs = get_left_num(_string, _pairArray[0]);
		if (lhs[1] != -4)
		{
			_string = string_delete(_string, lhs[1], string_length(lhs[0]));
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
		if (_num >= 0) //found a number
		{
			for(var n = i+1 ; i <= string_length(_string); n++) //keep validing further characters to confirm if double digit number
			{
				var _nextChar = string_char_at(_string, n);
				if (string_length(string_digits(_nextChar)) > 0)
				{
					_num = real(string(_num)+_nextChar);
				}
				else break;
				
			}
			return [_num, i];
		}
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
		if (_num >= 0)
		{
			for(var n = i-1 ; i > 0; n--) //keep validing further characters to confirm if double digit number
			{
				var _nextChar = string_char_at(_string, n);
				if (string_length(string_digits(_nextChar)) > 0)
				{
					_num = real(_nextChar+string(_num));
				}
				else break;
				
			}
			return [_num, n+1];
		}
		
	}
	return [-4,-4];
}

function split(_string, _numIndex){
	//get number and split it
	var _split = real(string_copy(_string, _numIndex, 2));
	var _num1 = _split div 2;
	var _num2 = ((_split div 2) + _split mod 2);
	
	//build new pair
	var _pair = ("[" + string(_num1) + "," + string(_num2) + "]");
	
	_string = string_replace(_string, _split, _pair);
	
	return _string;

}

function find_split_index(_string)
{
	for (var i = 1; i <= string_length(_string); i++)
	{
		var _char = string_char_at(_string, i);
		var _num = -4;
		if (string_length(string_digits(_char)) > 0) _num = string_digits(_char);
		if (_num >= 0)
		{
			//found a number, check for number immediately after
			var _char2 = string_char_at(_string, i+1);
			var _num2 = -4;
			if (string_length(string_digits(_char2)) > 0) _num2 = string_digits(_char2);
			if (_num2 >= 0)
			{
				//found a double digit number
				return i;
			}
		}
	}
	return -4;
}

function find_number_pair(_string)
{
	var _start = -4;
	var _comma = -4;
	var _end = -4;
	var success = false;
	//find open and close brace where only thing in between is numbers and a single comma
	for (var i = 1; i < string_length(_string); i++) //search open bracket
		{
			var _char1 = string_char_at(_string, i);
			if (_char1 = "[")
			{//opened a pair
				_start = i;	
				//find comma
				for (var _c = i+1; _c < string_length(_string); _c++)
				{
					var _char2 = string_char_at(_string, _c);
					if(_char2 == "[")
					{
						break;
					}
					else if (_char2 == ",")
					{
						_comma = _c;
						break;
					}
					
				}
				
				if(_comma == -4) continue; //failed at finding comma, try from next letter.
				else
				{ // found comma, now search for close bracket.
					for (var _e = _comma; _e <= string_length(_string); _e++)
					{
						var _char3 = string_char_at(_string, _e);
						if(_char3 == "[")
						{
							break;
						}
						else if (_char3 == "]")
						{
							_end = _e;
							success = true;
							break;
						}
					}
				}
			}
			if(success) break;
		}
	return [_start, _comma, _end];
}

function apply_magnitude(_string, _pairArray)
{
	//get left and right numbers
	var lhsIndex = _pairArray[0]+1;
	var lhsSize = _pairArray[1]-_pairArray[0]-1;
	var lhs = real(string_copy(_string, lhsIndex, lhsSize));
	var rhsIndex = _pairArray[1]+1;
	var rhsSize = _pairArray[2]-_pairArray[1]-1;
	var rhs = real(string_copy(_string, rhsIndex, rhsSize));
	
	//do math
	lhs = lhs * 3;
	rhs = rhs * 2;
	var result = lhs+rhs
	
	//update string
	var _pairLength = _pairArray[2]-_pairArray[0]+1;
	_string = string_delete(_string,_pairArray[0],_pairLength);
	_string = string_insert(string(result),_string,_pairArray[0]);
	return _string;
}

function find_magnitude(_string)
{
	// process string
	var solved = false;
	do
	{
		solved = true;
		
		var _pair = find_number_pair(_string);
		_string = apply_magnitude(_string, _pair);
		
		if(string_char_at(_string, 1) == "[")
		{
			solved = false
		}
		
	}
	until(solved)
	
	return _string;
}

function do_homework()
{
	var _length = array_length(numberStrings);
	for (var i = 0; i < _length-1; i++)
	{
		numberStrings[i+1] = add_numbers(i, i+1)
		numberStrings[i+1] = reduce_number(numberStrings[i+1]);
	}
	
	show_debug_message("Part 1: " + string(find_magnitude(numberStrings[_length-1])));
}

function do_homework_AGAIN()
{
	var _highest = 0;
	for (var _x = 0; _x < array_length(numberStrings); _x++)
	{
		for (var _y = 0; _y < array_length(numberStrings); _y++)
		{
			if(_y == _x) continue;
			else
			{
			
			var _string = add_numbers(_x, _y);
			_string = reduce_number(_string);
			var _result = find_magnitude(_string);
			_highest = max(_highest, _result);
			
			var _string = add_numbers(_y, _x);
			_string = reduce_number(_string);
			var _result = find_magnitude(_string);
			_highest = max(_highest, _result);
			}
		}
	}
	show_debug_message("Part 2: " + string(_highest));
}