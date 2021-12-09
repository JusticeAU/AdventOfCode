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
	
function load_input_day_6(_path){
	var file = file_text_open_read(_path);
	var str = file_text_read_string(file);
	var num = "";
	fishes[8] = 0;
	for (var i = 1; i-1 <= string_length(str); i++){ //loop through each character and run through below interpreter
		var char = string_char_at(str,i)
		switch(char){
			case ",": //end fish
				show_debug_message(num);
				fishes[real(num)] += 1;
				num = "";
				break;
			case "": //end of line/file
				show_debug_message(num);
				fishes[real(num)] += 1;
				num = "";
				break;
			default: //has to be a char
				num += char;
		}
	}

	
}
	
function day_6_1(_days){
	repeat(_days){
		var newFish = 0;
		for (var i = 0; i < array_length(fishes); i++){
			switch (i){
				case 0:
					newFish = fishes[0];
					break;
				default:
					fishes[i-1] = fishes[i];
					break;
			}
		}
		fishes[6] += newFish;
		fishes[8] = newFish;
	}
	
	var totalFish = 0;
	for (var i = 0; i < array_length(fishes); i++){
		totalFish += fishes[i];
	}
	show_debug_message(totalFish)
}
	
function load_input_day_7(_path){
	var file = file_text_open_read(_path);
	var str = file_text_read_string(file);
	var num = "";
	crabs = [];
	for (var i = 1; i-1 <= string_length(str); i++){ //loop through each character and run through below interpreter
		var char = string_char_at(str,i)
		switch(char){
			case ",": //end crab
				array_push(crabs,real(num));
				num = "";
				break;
			case "": //end of line/file
				array_push(crabs,real(num));
				num = "";
				break;
			default: //has to be a char
				num += char;
		}
	}
}
	
function day_7_1(){
	//median
	array_sort(crabs,true);
	var _median = crabs[array_length(crabs)/2]
	show_debug_message("median: " + string(_median));
	var fuel_median = 0;
	for (var i = 0; i < array_length(crabs); i++){
		fuel_median += abs(_median - crabs[i]);
	}
	show_debug_message("fuel median: " + string(fuel_median));
}

function day_7_2(){
	//part2
	//find largest offset
	_max = 0;
	for (var i = 0; i < array_length(crabs); i++){
		_max = max(_max, crabs[i]);
	}
	//loop through all possibly positions
	_movement = 999999999999;
	_best_pos = 0;
	for (var i = 0; i <= _max; i++){ //for each potential position
		var _fuel_cost = 0;
		for (var j = 0; j < array_length(crabs); j++){ // test against all crabs
			var _distance = abs(i - crabs[j])
			
			//my garbage
			/*for (var k = 1; k <= _distance; k++){
				_fuel_cost += k;
			}*/
			
			//formula
			 _fuel_cost += (power(_distance,2) + _distance) / 2;
		}
		if (_fuel_cost < _movement){
			_movement = _fuel_cost;
			_best_pos = i;
		}
	}
	show_debug_message("Best position: " + string(_best_pos));
	show_debug_message("fuel cost: " + string(_movement));
	
}
	
function load_input_day_8(_path){
	display = [];
	var file = file_text_open_read(_path);
	
	var line = 0;
	var index = 0;
	var signal = "";	
	
	while (!file_text_eof(file)) {
		var delimited = false;
		var str = file_text_read_string(file);
		array_push(display,[]);
		array_push(display[line],[]);
		array_push(display[line],[]);
		for (var i = 1; i-1 <= string_length(str); i++){
			switch(string_char_at(str,i)){
				case " ":
					array_push(display[line][delimited],signal);
					signal = "";
					break;
				case "|":
					i++
					delimited = true;
					break;
				case "":
					array_push(display[line][delimited],signal);
					signal = "";
					line++;
					file_text_readln(file);
					break;
				default:
					signal += string_char_at(str,i);
					break;
			}
		}
	}
}
	
function day_8_1(){
	var answer = 0;
	for (var i = 0; i < array_length(display); i++){
		for (var j = 0; j < array_length(display[i][1]); j++){
			var length = string_length(display[i][1][j]);
			switch(length){
				case 2:
					answer += 1;
					break;
				case 3:
					answer += 1;
					break;
				case 4:
					answer += 1;
					break;
				case 7:
					answer += 1;
					break;
				default:
					break;
			}
		}
	}
	show_debug_message(answer);
}
	
function day_8_2(){
	//loop through the whole array of data
	for (var lineIndex = 0; lineIndex < array_length(display); lineIndex++){
		var digits =["abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg"];
		//solve digits
		#region //Digit 1, 4, 7 and 8
		//find the str with length 2 - this is digit 1
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 2){
				digits[1] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
	
		//find the str with length 4 - this is digit 4
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 4){
				digits[4] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
	
		//find the str with length 3 - this is digit 7
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 3){
				digits[7] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
	
		//find the str with length 7 - this is digit 8
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 7){
				digits[8] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
		#endregion
		#region //Digit 3			
		//3 will have 5 bits AND contain the bits from 1.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 5){
				var matched = 0;
			
				//check if candidate the 2 bits from the 1 digit.
				for (var oneBits = 1; oneBits <= string_length(digits[1]); oneBits++){
					var oneBit = string_char_at(digits[1],oneBits);
					for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
						var potentialBit = string_char_at(str,potentialBits);
						if (oneBit == potentialBit){
							matched++;
						
						}
					}
					
				}
				if (matched = 2){ //found 3
					digits[3] = str;
					array_delete(display[lineIndex][0], strIndex, 1);
					break;
				}
			}
		}
		#endregion
		#region //Digit 6
		//6 will have 6 bits AND be missing a bit from 1.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 6){
				var matched = 0;
			
				//check if candidate is missing one of the bits from 1.
				for (var oneBits = 1; oneBits <= string_length(digits[1]); oneBits++){
					var oneBit = string_char_at(digits[1],oneBits);
					for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
						var potentialBit = string_char_at(str,potentialBits);
						if (oneBit == potentialBit){
							matched++;
						
						}
					}
					
				}
				if (matched = 1){ //found 6
					digits[6] = str;
					array_delete(display[lineIndex][0], strIndex, 1);
					break;
				}
			}
		}
	
		#endregion
		#region //Digit 9
		//9 will have 6 bits AND contain the bits from 4.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 6){
				var matched = 0;
			
				//check if candidate has the 4 bits from the 4 digit.
				for (var fourBits = 1; fourBits <= string_length(digits[4]); fourBits++){
					var fourBit = string_char_at(digits[4],fourBits);
					for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
						var potentialBit = string_char_at(str,potentialBits);
						if (fourBit == potentialBit){
							matched++;
						
						}
					}
					
				}
				if (matched = 4){ //found 4
					digits[9] = str;
					array_delete(display[lineIndex][0], strIndex, 1);
					break;
				}
			}
		}
		#endregion
		#region //Digit 0
		//0 will be the only remaining 6 digit bit.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 6){
				digits[0] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
		#endregion
		#region //Digit 2 and leaves 5
		//2 will have 5 bits and contain the missing bit from 6.
		//get missing bit from 6
		var missingBit = "abcdefg";
		for (var sixBits = 1; sixBits <= string_length(digits[6]); sixBits++){
			var sixBit = string_char_at(digits[6],sixBits);
			missingBit = string_replace(missingBit,sixBit,"");
		}
	
		//check if contains the missing bit
		repeat(2){
			var str = display[lineIndex][0][0];
			var matched = 0;
			
			//check if candidate contains the missing bit
			for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
				var potentialBit = string_char_at(str,potentialBits);
				if (missingBit == potentialBit){
					matched++;
						
				}
			}
		
			if (matched = 1){ //found 2
				digits[2] = str;
				array_delete(display[lineIndex][0], 0, 1);
			}
			else{ //found 5
				digits[5] = str;
				array_delete(display[lineIndex][0], 0, 1);
			}
		
		}
		#endregion
	
		#region //Match decrypted digits with display
		for (var digitIndex = 0; digitIndex < array_length(display[lineIndex][1]); digitIndex++){//process the 4? numbers
			var matched = false;
			var digitStr = display[lineIndex][1][digitIndex];
			var digitLength = string_length(digitStr);
			for (var potentialMatch = 0; potentialMatch < 10; potentialMatch++){
				var potentialMatchStr = digits[potentialMatch]
				var potentialMatchLength = string_length(potentialMatchStr);
			
				if (potentialMatchLength == digitLength){ //display digit has same length as digit index
					var matches = 0;
					for (var char1Index = 1; char1Index <= digitLength; char1Index++){
						var char1 = string_char_at(digitStr, char1Index);
						for (var char2Index = 1; char2Index <= digitLength; char2Index++){
							var char2 = string_char_at(potentialMatchStr, char2Index);
							if (char1 == char2){
								matches++;
							}
						}
					}
					if (matches == digitLength){
						display[lineIndex][1][digitIndex] = potentialMatch;
						matched = true;
					}
				}
				if (matched) break;
			}
		}
		#endregion
		
	}
	
	//sum the solved data
	var result = 0;
	for (var line = 0; line < array_length(display); line++){
		for (var digit = 0; digit < array_length(display[line][1]); digit++){
			switch (digit){
				case 0:
					result += (display[line][1][digit]) * 1000;
					break;
				case 1:
					result += (display[line][1][digit]) * 100;
					break;
				case 2:
					result += (display[line][1][digit]) * 10;
					break;
				case 3:
					result += (display[line][1][digit]);
					break;
			}
		}
	}
	show_debug_message(result);
	
}