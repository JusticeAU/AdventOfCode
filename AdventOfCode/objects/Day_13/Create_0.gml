/// @description 
function load_input_day_13(_path){
	paper = [[]];
	folds = [[]]
	file = file_text_open_read(_path);
	var coordinateImportComplete = false;
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _str = file_text_read_string(file);
		var _end = string_length(_str);
		if (!coordinateImportComplete){
			var _end = string_length(_str);
			if (_end == 0){
				coordinateImportComplete = true;
				i=-1; //reset index because we're importing in to a different empty array now.
				file_text_readln(file);
				continue;
			}
			else{
				var _delimiter = string_pos(",",_str);
				var _x = real(string_copy(_str,0,_delimiter-1));
				var _y = real(string_copy(_str,_delimiter+1,_end));
				paper[_y][_x]= 1;
			}
		}
		else{ //reading folds now
			var 
			var _foldType = string_char_at(_str,12); //magic number cause thats just where it is in the input
			var _coordinate = real(string_copy(_str,14,_end));
			folds[i][0] = _foldType;
			folds[i][1] = _coordinate;
		}
		file_text_readln(file);
	}
	file_text_close(file);
}

function fold(_foldAlong,_index){
	switch(_foldAlong){
		case "y":
			for (var _y = _index; _y < array_length(paper); _y++){
				for (var _x = 0; _x < array_length(paper[_y]); _x++){
					if (paper[_y][_x]) paper[(_index*2)-_y][_x] = paper[_y][_x];
				}
			}
			array_resize(paper,_index);
			break;
		case "x":
			for (var _y = 0; _y < array_length(paper); _y++){
				for (var _x = _index; _x < array_length(paper[_y]); _x++){
					if (paper[_y][_x]) paper[_y][(_index*2)-_x] = paper[_y][_x];
				}
			}
			for(var _y = 0; _y < array_length(paper); _y++) if(is_array(paper[_y])) array_resize(paper[_y],_index);
			break;
	}
	
}

function day_13(){
	for (var i = 0; i < array_length(folds); i++){
		fold(folds[i][0], folds[i][1]);
		if(i = 0){
			var _dots = 0;
			for (var _y = 0; _y < array_length(paper); _y++){
				for (var _x = 0; _x < array_length(paper[_y]); _x++){
					if (paper[_y][_x]) _dots++;
				}
			}
		show_debug_message("Part 1: " + string(_dots));
		}
	}
	show_debug_message("Part 2: ");
	for (var _y = 0; _y < array_length(paper); _y++){
		var _str = "";
		for (var _x = 0; _x < array_length(paper[_y]); _x++){
			if (paper[_y][_x]) _str += "▓";
			else _str += "░";
		}
		show_debug_message(_str);
		}
		
}