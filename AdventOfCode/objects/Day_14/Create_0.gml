/// @description 
function load_input_day_14(_path){
	charCount = ds_map_create();
	insertionRules = [];
	file = file_text_open_read(_path);
	str = file_text_read_string(file);
	//add inital characters to charCount list
	for (var i = 1; i <= string_length(str); i++){
		count_character(string_char_at(str,i));
	}
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
		show_debug_message("step: " + string(step));
		insertions = [];
		
		//search string for pairs
		for (var pairIndex = 0; pairIndex < array_length(insertionRules); pairIndex++){
			//error - should be processing per pair in string, not per pairlist item otherwise order of insertion wont be valid
			//OR every time i make an insertion at a position, process the remainder of my insertion list and increase positions only where the position is larger than the one we just inserted
			var _matches = string_count(insertionRules[pairIndex][0],str);
			var _lastMatchPos = 0;
			for(var matchNumber = 1; matchNumber <= _matches; matchNumber++){
				//show_debug_message("checking from: " + string(_lastMatchPos));
				var _insertionPos = string_pos_ext(insertionRules[pairIndex][0],str,_lastMatchPos)+1;
				array_push(insertions,[insertionRules[pairIndex][1],_insertionPos]);
				//show_debug_message("Found: " + insertionRules[pairIndex][0] + " at : " + string(_insertionPos-1) + " inserting " + insertionRules[pairIndex][1] + " at " + string(_insertionPos));
				_lastMatchPos = _insertionPos-1;
	
			}
		}
		//if (step == 3) continue;
		//push insertion list
		for (var _insertion = 0; _insertion < array_length(insertions); _insertion++){
			var _subStr = insertions[_insertion][0];
			var _position = insertions[_insertion][1];
			str = string_insert(_subStr, str, _position);
			count_character(_subStr);
			increase_indexes(_insertion, insertions[_insertion][1])
		}
	}
	
	//get string count
	
	
}

function increase_indexes(_from,_isAbove){
	for (var _insertion = _from+1; _insertion < array_length(insertions); _insertion++){
		if(insertions[_insertion][1] >= _isAbove) insertions[_insertion][1]++
	}
}

function count_character(_char){
	if(ds_map_exists(charCount, _char)){
			charCount[? _char] += 1;
		}
		else ds_map_set(charCount, _char, 1);
}