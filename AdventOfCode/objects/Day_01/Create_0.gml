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

	show_debug_message("Part 1 - Increases: " + string(increases));
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
	show_debug_message("Part 2 - Increases: " + string(increases));
}
