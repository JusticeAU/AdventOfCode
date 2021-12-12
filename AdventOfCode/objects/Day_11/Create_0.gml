/// @description 
function load_input_day_11(_path){
	input = [[]];
	file = file_text_open_read(_path)
	flashes = 0;
	iterations = 0;
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _str = file_text_read_string(file);
		for (var j = 1; j <= string_length(_str); j++){
			var _char = string_char_at(_str, j);
			array_push(input[i],[]);
			array_push(input[i][j-1],real(_char));	//value
			array_push(input[i][j-1],false);		//has flashed
			
		}
		file_text_readln(file);
		
		if (!file_text_eof(file)) array_push(input,[]);
	}
	file_text_close(file);
}

function day_11(){
	do{
		iterations++;
		// 1. increase energy
		for (var _y = 0; _y < array_length(input); _y++){
			for (var _x = 0; _x < array_length(input[_y]); _x++){
				input[_y][_x][0]++;
			}
		}
		
		// 2. processes flashes
		do{
			var _didAFlash = false;
			
			for (var _y = 0; _y < array_length(input); _y++){
				for (var _x = 0; _x < array_length(input[_y]); _x++){
					if (input[_y][_x][0] > 9 && input[_y][_x][1] = false){
						flash(_y,_x);
						_didAFlash = true;
					}
				}
			}
		}
		until (_didAFlash == false);  //break out when no cells are triggering flashes.
		
		// 3. reset flashed cells
		for (var _y = 0; _y < array_length(input); _y++){
			for (var _x = 0; _x < array_length(input[_y]); _x++){
				if(input[_y][_x][0] > 9){
					input[_y][_x][0] = 0;
					input[_y][_x][1] = 0;
					
				}
			}
		}
		
		// 4. check for brighest possible flash
		var allFlashed = true;
		for (var _y = 0; _y < array_length(input); _y++){
			for (var _x = 0; _x < array_length(input[_y]); _x++){
				if(input[_y][_x][0] != 0){
					allFlashed = false;
				}
			}
		}
		if(iterations == 100) show_debug_message("Part 1: " + string(flashes));
	}
	until(allFlashed == true);
	show_debug_message("Part 2: " + string(iterations));
}

function flash(_y,_x){
	flashes++
	input[_y][_x][1] = true; //mark this boi as flashed.
	for (var _yy = _y-1; _yy <= _y+1; _yy++){
		
		if ((_yy < 0) or (_yy >= array_length(input))) continue; //not safe
		for (var _xx = _x-1; _xx <= _x+1; _xx++){
			if ((_xx < 0) or (_xx >= array_length(input[_yy]))) continue; //not safe
			input[_yy][_xx][0]++;
		}
	}
}