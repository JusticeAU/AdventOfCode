/// @description 
function load_input_day_14(_path){
	insertionRules = [];
	file = file_text_open_read(_path);
	str = file_text_read_string(file);
	file_text_readln(file);
	file_text_readln(file);
	
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _str = file_text_read_string(file);
		var _pair = string_copy(_str,1,2);
		var _value = string_copy(_str,7,1);
		array_push(insertionRules,[_pair,_value]);
		file_text_readln(file);
	}
	file_text_close(file);
}

function day_14_1(_steps){
	for (var step = 1; step <= _steps; step++){
		insertions = [];
		for (var pairIndex = 0; pairIndex < array_length(insertionRules); pairIndex++){
			//error - should be pressing per par in string, not per pairlist index otherwise order of insertion gets messed up.
			//OR every time i make an insertion at a position, process the remainder of my insertion list and increase positions only where the position is larger than the one we just inserted
			var _matches = string_count(insertionRules[pairIndex][0],str);
			show_debug_message(_matches);
			var _lastMatchPos = 0;
			for(var matchNumber = 1; matchNumber <= _matches; matchNumber++){
				var _insertionPos =  string_pos_ext(insertionRules[pairIndex][0],str,_lastMatchPos);
				array_push(insertions,[insertionRules[pairIndex][1],_insertionPos]);
			}
		}
		
		for (var _insertion = 0; _insertion < array_length(insertions); _insertion++){
			show_debug_message("yea");
			var _subStr = insertions[_insertion][0];
			var _position = insertions[_insertion][1]+_insertion;
			str = string_insert(_subStr, str, _position);
		}
	}
	
	
}