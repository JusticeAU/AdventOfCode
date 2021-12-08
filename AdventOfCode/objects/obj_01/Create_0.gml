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
	
	bingoNumbers = []; //array for bingo numbers
	file = file_text_open_read(_path);
	
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
	
	file_text_readln(file); //next line
	file_text_readln(file); //skip over blank.
	
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

function day_4_1(){
	var gameEnded = false;
	var winningNumber = 0;
	var winningBoard = 0;
	//loop through bingo numbers
	for (var bingoNumber = 0; bingoNumber < array_length(bingoNumbers); bingoNumber++){
		show_debug_message("Bingo Number: " + string(bingoNumbers[bingoNumber]));
		//loop through bingo boards
		for (var _boardIndex = 0; _boardIndex < array_length(bingoBoards); _boardIndex++){
			for (var _y = 0; _y < array_length(bingoBoards[_boardIndex]); _y++){
				for (var _x = 0; _x < array_length(bingoBoards[_boardIndex][_y]); _x++){
					if (bingoNumbers[bingoNumber] == bingoBoards[_boardIndex][_y][_x]){
						show_debug_message("ITS A BINGO!!!!!");
						show_debug_message("Board Number: " + string(_boardIndex));
						show_debug_message("Row Number: " + string(_y));
						show_debug_message("Column Number: " + string(_x));
						show_debug_message("Number: " + string(bingoBoards[_boardIndex][_y][_x]));
						bingoBoards[_boardIndex][_y][_x] = 0;
						gameEnded = win_check(_boardIndex,_y,_x);
					}
					if (gameEnded) break;
				}
				if (gameEnded) break;
			}
			if (gameEnded) break;
		}
		if (gameEnded){
			winningNumber = real(bingoNumbers[bingoNumber]);
			winningBoard = _boardIndex;
			break;
		}
	}
	var boardSum = sum_board(_boardIndex);
	show_debug_message(winningNumber * boardSum);
}

function day_4_2(){
	wonBoards = [];
	var gameEnded = false;
	//loop through bingo numbers
	for (var bingoNumber = 0; bingoNumber < array_length(bingoNumbers); bingoNumber++){
			show_debug_message("Bingo Number: " + string(bingoNumbers[bingoNumber]));
			//loop through bingo boards
			for (var _boardIndex = 0; _boardIndex < array_length(bingoBoards); _boardIndex++){
				gameEnded = false;
				//check if a board has won already.
				var won = false;
				for (var wonNumber = 0; wonNumber < array_length(wonBoards); wonNumber++){
					if (wonBoards[wonNumber] == _boardIndex){
						show_debug_message("board already won: " + string(_boardIndex));
						won = true;
						break;
					}
				}
				if (!won){
					for (var _y = 0; _y < array_length(bingoBoards[_boardIndex]); _y++){
						for (var _x = 0; _x < array_length(bingoBoards[_boardIndex][_y]); _x++){
							if (bingoNumbers[bingoNumber] == bingoBoards[_boardIndex][_y][_x]){
								//show_debug_message("ITS A BINGO!!!!!");
								//show_debug_message("Board Number: " + string(_boardIndex));
								//show_debug_message("Row Number: " + string(_y));
								//show_debug_message("Column Number: " + string(_x));
								//show_debug_message("Number: " + string(bingoBoards[_boardIndex][_y][_x]));
								bingoBoards[_boardIndex][_y][_x] = 0;
								gameEnded = win_check(_boardIndex,_y,_x);
							}
							if (gameEnded) break;
						}
						if (gameEnded) break;
					}
					if (gameEnded){
						array_push(wonBoards,_boardIndex);
						lastWon = _boardIndex;
						lastWinningNum = real(bingoNumbers[bingoNumber]);
					}
				}
			}
		}
	var boardSum = sum_board(lastWon);
	show_debug_message(lastWinningNum * boardSum);
	show_debug_message(lastWinningNum);
}

function win_check(_boardIndex,_y,_x){
	//check horizontal
	var h = 0;
	for (var i = 0; i < 5; i++){
		h += bingoBoards[_boardIndex][_y][i];
	}
	if (h == 0){
		show_debug_message("Board has been won");
		show_debug_message(_boardIndex);
		
		return true;
	}
	//check vertical
	var v = 0;
	for (var i = 0; i < 5; i++){
		v += bingoBoards[_boardIndex][i][_x];
	}
	if (v == 0){
		show_debug_message("Board has been won");
		show_debug_message(_boardIndex);
		return true;
	}
}
	
function sum_board(_boardIndex){
	var _sum = 0;
	for (var _y = 0; _y < array_length(bingoBoards[_boardIndex]); _y++){
		for (var _x = 0; _x < array_length(bingoBoards[_boardIndex][_y]); _x++){
			_sum += bingoBoards[_boardIndex][_y][_x];
		}
	}
	return _sum;
}
	
function load_input_day_5(_path){
	#macro x1 0
	#macro y1 1
	#macro x2 2
	#macro y2 3
	
	var file = file_text_open_read(_path);
	coordinates = [];
	
	largest_x = 0; //tracked during reading of file and used for grid creation
	largest_y = 0;
	function track_largest(_coordinateNumber, _coordinate){
		if (_coordinateNumber == x1) or (_coordinateNumber == x2) largest_x = max(largest_x, _coordinate);
		else largest_y = max(largest_y, _coordinate);
	}
	
	var lineNumber = 0;
	while !(file_text_eof(file)){
		var coordinateNumber = 0;
		var lineString = file_text_read_string(file);
		var num = "";
		array_push(coordinates,[0,0,0,0]);
		for (var i = 1; i-1 <= string_length(lineString); i++){ //loop through each character and run through below interpreter
			var char = string_char_at(lineString,i)
			switch(char){
				case " ": //reached end of first two ordinates, expecting the " -> " notation, so we skip over it to the next coordinate.
					coordinates[lineNumber][coordinateNumber] = real(num);
					track_largest(coordinateNumber, real(num));
					coordinateNumber++;
					i += 3;
					num = "";
					break;
				case "": //end of the line.
					coordinates[lineNumber][coordinateNumber] = real(num);
					track_largest(coordinateNumber, real(num));
					coordinateNumber++;
					num = "";
					break;
				case ",": //indicates end of an x coordinate and start of a y coordinate
					coordinates[lineNumber][coordinateNumber] = real(num);
					track_largest(coordinateNumber, real(num));
					coordinateNumber++;
					num = "";
					break;
				default: //has to be a char
					num += char;
			}
		}
		file_text_readln(file); //move to next line in file.
		lineNumber++;
	}
}
	
function day_5_1(){
	//remove diagonals
	for (var i = 0; i < array_length(coordinates); i++){
		if !((coordinates[i][x1] == coordinates[i][x2]) or (coordinates[i][y1] == coordinates[i][y2])){
			array_delete(coordinates, i, 1);
			i--;
		}
	}
	
	//create our grid
	grid = ds_grid_create(largest_x,largest_y);
	//show_debug_message(array_length(coordinates));
	//show_debug_message(coordinates[322][x1]);
	//draw lines
	for (var line = 0; line < array_length(coordinates); line++){
		show_debug_message(coordinates[line][x1]);
		
		switch(coordinates[line][x1] == coordinates[line][x2]){
			case true: //vertical
				show_debug_message("drawing a vertical line");
				for (var target = min(coordinates[line][y1],coordinates[line][y2]); target <= max(coordinates[line][y1],coordinates[line][y2]); target++){
					show_debug_message("drawing line at: x:" + string(coordinates[line][x1]) + " y:" + string(target));
					grid[# coordinates[line][x1], target] += 1;
					
				}
				break;
			case false: //horizontal
				show_debug_message("drawing a horizontal line");
				for (var target = min(coordinates[line][x1],coordinates[line][x2]); target <= max(coordinates[line][x1],coordinates[line][x2]); target++){
					show_debug_message("drawing line at: y:" + string(coordinates[line][y1]) + " x:" + string(target));
					grid[# target, coordinates[line][y1]] += 1;
					
				}
				break;
		}
	}
	
	//check for intersections
	intersections = 0;
	for (var _x = 0; _x < ds_grid_width(grid); _x++){
		for (var _y = 0; _y < ds_grid_height(grid); _y++){
			if (grid[# _x, _y] >= 2) intersections++;
		}
	}
	show_debug_message(intersections);
}

function day_5_2(){
	//remove diagonals
	/*for (var i = 0; i < array_length(coordinates); i++){
		if !((coordinates[i][x1] == coordinates[i][x2]) or (coordinates[i][y1] == coordinates[i][y2])){
			array_delete(coordinates, i, 1);
			i--;
		}
	}*/
	
	//create our grid
	grid = ds_grid_create(largest_x+1,largest_y+1);


	//draw lines
	for (var line = 0; line < array_length(coordinates); line++){
		switch(line_orientation(line)){
			case "vertical": //vertical
				show_debug_message("drawing a vertical line");
				for (var target = min(coordinates[line][y1],coordinates[line][y2]); target <= max(coordinates[line][y1],coordinates[line][y2]); target++){
					show_debug_message("drawing line at: x:" + string(coordinates[line][x1]) + " y:" + string(target));
					grid[# coordinates[line][x1], target] += 1;
					
				}
				break;
			case "horizontal": //horizontal
				show_debug_message("drawing a horizontal line");
				for (var target = min(coordinates[line][x1],coordinates[line][x2]); target <= max(coordinates[line][x1],coordinates[line][x2]); target++){
					show_debug_message("drawing line at: y:" + string(coordinates[line][y1]) + " x:" + string(target));
					grid[# target, coordinates[line][y1]] += 1;
					
				}
				break;
			case "diagonal":
				show_debug_message("drawing a diagonal line");
				var length = max(coordinates[line][x1],coordinates[line][x2]) - min(coordinates[line][x1],coordinates[line][x2]);
				for (var i = 0; i <= length; i++){
					var target_x = coordinates[line][x1] + (sign(coordinates[line][x2]-coordinates[line][x1])*i)
					var target_y = coordinates[line][y1] + (sign(coordinates[line][y2]-coordinates[line][y1])*i)
					show_debug_message("drawing at: x:" + string(target_x) + " y:" + string(target_y));
					grid[# target_x, target_y] += 1;
				}
				break;
		}
	}
	
	//check for intersections
	intersections = 0;
	for (var _x = 0; _x < ds_grid_width(grid); _x++){
		for (var _y = 0; _y < ds_grid_height(grid); _y++){
			if (grid[# _x, _y] >= 2) intersections++;
		}
	}
	show_debug_message(intersections);
}

function line_orientation(lineIndex){
	if (coordinates[lineIndex][x1] == coordinates[lineIndex][x2]) return "vertical";
	else if (coordinates[lineIndex][y1] == coordinates[lineIndex][y2]) return "horizontal";
	else return "diagonal";
}