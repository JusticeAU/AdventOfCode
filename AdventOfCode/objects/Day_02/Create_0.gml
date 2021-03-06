/// @description 

function load_input_day_2(_path){
	//read in file to array
	input2[0][0] = 0;
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		input2[i][0] = string_letters(_line);//_move // -1 = down. 0 = forward - 1 = up 
		input2[i][1] = string_digits(_line); //_delta
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
show_debug_message("Part 1: " + string(_depth * _distance));
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
		}
	}

show_debug_message("Part 2: " + string(_depth * _distance));
}
