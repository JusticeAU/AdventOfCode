/// @description 
function load_input_day_10(_path){
	input = [];
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		input[i] = file_text_read_string(file);
		file_text_readln(file);
	}
	file_text_close(file);
}

function day_10_1(){
	_score1 = 0;
	_score2 = [];
	for (var _lineIndex = 0; _lineIndex < array_length(input); _lineIndex++){
		_depth = 0;
		brackets = [];
		var ok = true;
		for (var _charIndex = 1; _charIndex <= string_length(input[_lineIndex]); _charIndex++){
			var _char = string_char_at(input[_lineIndex], _charIndex);
			switch(_char){
				case "(":
					open(_char);
					break;
				case "[":
					open(_char);
					break;
				case "{":
					open(_char);
					break;
				case "<":
					open(_char);
					break;
			
				case ")":
					ok = close(_char);
					break;
				case "]":
					ok = close(_char);
					break;
				case "}":
					ok = close(_char);
					break;
				case ">":
					ok = close(_char);
					break;
			
				default: break;
			}
			if !ok break; //invalid char
		}
		if ok{ //valid line - potentially needs completion
			var _lineScore = 0;
			
			for (var i = array_length(brackets)-1; i >= 0; i--){
				_lineScore *= 5;
				switch(brackets[i]){
					case "(":
						_lineScore += 1;
						break;
					case "[":
						_lineScore += 2;
						break;
					case "{":
						_lineScore += 3;
						break;
					case "<":
						_lineScore += 4;
						break;
				}
				
			}
			array_push(_score2,_lineScore);
		}
		
		
	}
	array_sort(_score2, true);
	show_debug_message("Part 1: " + string(_score1));
	show_debug_message("Part 2: " + string(_score2[array_length(_score2)/2]));
}

function open(_char){
	array_push(brackets, _char);
	_depth++;
}
	
function close(_char){
		var index = max(0,_depth-1)
		var closer = get_closer(brackets[index]);
		if (_char != closer){
			//show_debug_message("Invalid Syntax Error - Expected: " + closer + " Got: " + _char);
			_score1 += get_score(_char);
			return false;
		}
		else{
			array_delete(brackets,index,1);
			_depth--;
			return true;
		}
}

function get_closer(_char){
	switch(_char){
		case "(":
			return ")";
			break;
		case "[":
			return "]";
			break;
		case "{":
			return "}";
			break;
		case "<":
			return ">";
			break;
			
		default: break;
	}
}

function get_score(_char){
	switch(_char){
		case ")":
			return 3;
			break;
		case "]":
			return 57;
			break;
		case "}":
			return 1197;
			break;
		case ">":
			return 25137;
			break;
		default: break;
	}
}