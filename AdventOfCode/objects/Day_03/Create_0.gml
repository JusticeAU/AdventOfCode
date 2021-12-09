/// @description 

function load_input_day_3(_path){
	//read in file to array
	input3[0][0] = 0;
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		for (var j = 0; j < string_length(_line); j++){
			input3[i][j] = string_char_at(_line,j+1)
		}
		file_text_readln(file); 
	}
	file_text_close(file);
	
}
	
function day_3_1(){
	var _width = array_length(input3[0]);
	var _height = array_length(input3);
	_gamma[_width-1] = 0;
	
	// count bits
	for (var i = 0; i < _height; i++){
		for (var j = 0; j < _width; j++){
			_gamma[j] += input3[i][j];
		}
	}
	
	//begin build of result
	_gamma_base = 0;
	_epsilon_base = 0;
	for (var i = 0; i < _width; i++){
		_gamma[i] = _gamma[i] > (_height / 2);
		
		//build binary result
		if (_gamma[i]) _gamma_base = _gamma_base | 1 << _width-i-1;
		else _epsilon_base = _epsilon_base | 1 << _width-i-1;
	}
	
	//calculate
	show_debug_message("Part 1: " + string(_gamma_base*_epsilon_base));
	
}
	
function day_3_2(){
	
	common = -4;
	var _width = array_length(input3[0]);

	_o2 = [];
	_co2 = [];
	
	array_copy(_o2,0,input3,0,array_length(input3));
	array_copy(_co2,0,input3,0,array_length(input3));
	
	for (var i = 0; array_length(_o2) != 1; i++){
		common = most_common(_o2,i);
		process(_o2,i,common);
	}
	
	for (var i = 0; array_length(_co2) != 1; i++){
		common = most_common(_co2,i);
		process(_co2,i,common,false);
	}
	
	//begin build of result
	_o2_base = 0;
	_co2_base = 0;
	for (var i = 0; i < array_length(_o2[0]); i++){
		
		//build binary result
		if (_o2[0][i]) _o2_base = _o2_base | 1 << _width-i-1;
		if (_co2[0][i]) _co2_base = _co2_base | 1 << _width-i-1;
	}
	
	//calculate
	show_debug_message("Part 2: " + string(_o2_base*_co2_base));
	
}

function most_common(_array,_column){
	var _1s = 0;

	for (var i = 0; i < array_length(_array); i++){
		
		if _array[i][_column] _1s++;
		
	}
	
	if _1s > (array_length(_array)/2) return 1;
	else if _1s == (array_length(_array)/2) return -1;
	else return 0;
}

function process(_array, _column, _most_common,_o2=true){
	
	for (var i = 0; i < array_length(_array); i++){
		if(_o2){
			switch(_most_common){
				case 1:
					if !(_array[i][_column] == _most_common){
						//show_debug_message("Most Common is 1 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					//else show_debug_message("Most Common is 1 - Keeping: " + string(_array[i][_column]));
					break;
				case 0:
					if !(_array[i][_column] == _most_common){
						//show_debug_message("Most Common is 0 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					//else show_debug_message("Most Common is 0 - Keeping: " + string(_array[i][_column]));
					break;
				case -1:
					if !(_array[i][_column] == 1){
						//show_debug_message("Most Common is null - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					//else show_debug_message("Most Common is null - Keeping: " + string(_array[i][_column]));
					break;
			}
		}
		else{
			switch(_most_common){
				case 1:
					if (_array[i][_column] == _most_common){
						//show_debug_message("Most Common is 1 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					//else show_debug_message("Most Common is 1 - Keeping: " + string(_array[i][_column]));
					break;
				case 0:
					if (_array[i][_column] == _most_common){
						//show_debug_message("Most Common is 0 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					//else show_debug_message("Most Common is 0 - Keeping: " + string(_array[i][_column]));
					break;
				case -1:
					if (_array[i][_column] == 1){
						//show_debug_message("Most Common is null - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					//else show_debug_message("Most Common is null - Keeping: " + string(_array[i][_column]));
					break;
			}
		}
	}
}
