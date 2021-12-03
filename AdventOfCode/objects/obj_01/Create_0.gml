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