/// @description 

function load_input_day_1(_path){
	//read in file to array
	input = [];
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		input[i] = file_text_read_real(file);
	}
	file_text_close(file);
}

function day_1_1(){
	//process file - Challenge 1
	var previousLine = input[0];
	var increases = 0;
	for (var i = 1; i < array_length(input); i++)
	{
		increases += input[i] > previousLine ? 1 : 0;
		//update previous line
		previousLine = input[i];
	}

	show_debug_message("Challenge 1 - Increases: " + string(increases));
}

function day_1_2(){
	//Process file - Challenge 2
	var increases = 0;
	for (var i = 1; i < array_length(input)-2; i++)
	{
		var a = input[i-1],
			b = input[i],
			c = input[i+1],
			d = input[i+2];
		
		var _new = b+c+d,
			_old = a+b+c;
	
		increases += _new > _old;
	}
	show_debug_message("Challenge 2 - Increases: " + string(increases));
}

function load_input_day_2(_path){
	//read in file to array
	input2[0][0] = 0;
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		//var _space = string_pos(_line, " ");
		//var _end = string_length(_line)
	
		input2[i][0] = string_letters(_line);//_move // -1 = down. 0 = forward - 1 = up 
		input2[i][1] = string_digits(_line); //_delta
		show_debug_message(_line);
		file_text_readln(file); 
	}
	file_text_close(file);
}
	
function day_2_1(){
	_depth = 0;
	_distance = 0;
	
	for (var i = 0; i < array_length(input2); i++)
	{
		switch(input2[i][0]){
			case "forward":
				_distance += input2[i][1];
				break;
			case "down":
				_depth += input2[i][1];
				break;
			case "up":
				_depth -= input2[i][1];
				break;
			
		}
	}
show_debug_message(_depth * _distance);
}

function day_2_2(){
	_depth = 0;
	_distance = 0;
	_aim = 0;
	
	for (var i = 0; i < array_length(input2); i++)
	{
		switch(input2[i][0]){
			case "forward":
				_distance += input2[i][1];
				_depth += real(_aim) * real(input2[i][1]);
				break;
			case "down":
				_aim += input2[i][1];
				break;
			case "up":
				_aim -= input2[i][1];
				break;
			
			show_debug_message(_aim);
		}
	}

show_debug_message(_depth * _distance);
}
	
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
	show_debug_message(_gamma_base*_epsilon_base);
	
}
	
function day_3_2(){
	
	common = -4;
	var _width = array_length(input3[0]);
	var _height = array_length(input3);
	
	
	_o2 = [];
	_co2 = [];
	
	array_copy(_o2,0,input3,0,array_length(input3));
	array_copy(_co2,0,input3,0,array_length(input3));
	
	for (var i = 0; array_length(_o2) != 1; i++){
		show_debug_message("Pass/Index: " + string(i));
		common = most_common(_o2,i);
		show_debug_message("Common: " + string(common));
		process(_o2,i,common);
		show_debug_message("Remaining: " + string(array_length(_o2)));
	}
	
	for (var i = 0; array_length(_co2) != 1; i++){
		show_debug_message("Pass/Index: " + string(i));
		common = most_common(_co2,i);
		show_debug_message("Common: " + string(common));
		process(_co2,i,common,false);
		show_debug_message("Remaining: " + string(array_length(_o2)));
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
	show_debug_message(_o2_base*_co2_base);
	
}

function most_common(_array,_column){
	var _1s = 0;

	for (var i = 0; i < array_length(_array); i++){
		
		if _array[i][_column] _1s++;
		
	}
	show_debug_message(_1s);
	show_debug_message(array_length(_array)/2);
	
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
						show_debug_message("Most Common is 1 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					else show_debug_message("Most Common is 1 - Keeping: " + string(_array[i][_column]));
					break;
				case 0:
					if !(_array[i][_column] == _most_common){
						show_debug_message("Most Common is 0 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					else show_debug_message("Most Common is 0 - Keeping: " + string(_array[i][_column]));
					break;
				case -1:
					if !(_array[i][_column] == 1){
						show_debug_message("Most Common is null - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					else show_debug_message("Most Common is null - Keeping: " + string(_array[i][_column]));
					break;
			}
		}
		else{
			switch(_most_common){
				case 1:
					if (_array[i][_column] == _most_common){
						show_debug_message("Most Common is 1 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					else show_debug_message("Most Common is 1 - Keeping: " + string(_array[i][_column]));
					break;
				case 0:
					if (_array[i][_column] == _most_common){
						show_debug_message("Most Common is 0 - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					else show_debug_message("Most Common is 0 - Keeping: " + string(_array[i][_column]));
					break;
				case -1:
					if (_array[i][_column] == 1){
						show_debug_message("Most Common is null - Discarding: " + string(_array[i][_column]));
						array_delete(_array,i,1);
						i--;
					}
					else show_debug_message("Most Common is null - Keeping: " + string(_array[i][_column]));
					break;
			}
		}
	}
}

function load_input_day_4(_path){
	
	bingoNumbers = []; //array for bing numbers
	file = file_text_open_read(_path)
	
	//read the bingo numbers from the first line of the file
	var line = file_text_read_string(file);
	var str = "";
	var bingoIndex = 0;
	for (var i = 1; i-1 <= string_length(line); i++){ //loop through each character looking for end of line or commas,
		var char = string_char_at(line,i)
		switch(char){
			case "": //end of line
				bingoNumbers[bingoIndex] = str;
				bingoIndex++;
				str = "";
				break;
			case ",": //comma delimiter
				bingoNumbers[bingoIndex] = str;
				bingoIndex++;
				str = "";
				break;
			default: //has to be a char
				str += char;
		}
	}
	
	show_debug_message(file_text_readln(file)); //next line
	show_debug_message(file_text_readln(file)); //skip over blank.
	
	//begin reading bingo boards
	bingoBoards = [];
	var boardIndex = 0;
	do{
		var columnEnd = false;
		for (var _y = 0; !columnEnd; _y++){
			var rowEnd = false;
			for (var _x = 0; !rowEnd; _x++){
				bingoBoards[boardIndex][_y][_x] = file_text_read_real(file);
				rowEnd = file_text_eoln(file);
			}
			
			file_text_readln(file);
			columnEnd = file_text_eoln(file);			
		}
		boardIndex++;
	}
	until(file_text_eof(file))
	file_text_close(file);
}