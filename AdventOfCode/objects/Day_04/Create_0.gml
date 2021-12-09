/// @description 
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
		//show_debug_message("Bingo Number: " + string(bingoNumbers[bingoNumber]));
		//loop through bingo boards
		for (var _boardIndex = 0; _boardIndex < array_length(bingoBoards); _boardIndex++){
			for (var _y = 0; _y < array_length(bingoBoards[_boardIndex]); _y++){
				for (var _x = 0; _x < array_length(bingoBoards[_boardIndex][_y]); _x++){
					if (bingoNumbers[bingoNumber] == bingoBoards[_boardIndex][_y][_x]){
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
	show_debug_message("Part 1: " + string(winningNumber * boardSum));
}

function day_4_2(){
	wonBoards = [];
	var gameEnded = false;
	//loop through bingo numbers
	for (var bingoNumber = 0; bingoNumber < array_length(bingoNumbers); bingoNumber++){
			//show_debug_message("Bingo Number: " + string(bingoNumbers[bingoNumber]));
			//loop through bingo boards
			for (var _boardIndex = 0; _boardIndex < array_length(bingoBoards); _boardIndex++){
				gameEnded = false;
				//check if a board has won already.
				var won = false;
				for (var wonNumber = 0; wonNumber < array_length(wonBoards); wonNumber++){
					if (wonBoards[wonNumber] == _boardIndex){
						//show_debug_message("board already won: " + string(_boardIndex));
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
	show_debug_message("Part 2: " + string(lastWinningNum * boardSum));
	
}

function win_check(_boardIndex,_y,_x){
	//check horizontal
	var h = 0;
	for (var i = 0; i < 5; i++){
		h += bingoBoards[_boardIndex][_y][i];
	}
	if (h == 0){
		//show_debug_message("Board has been won");
		//show_debug_message(_boardIndex);
		return true;
	}
	//check vertical
	var v = 0;
	for (var i = 0; i < 5; i++){
		v += bingoBoards[_boardIndex][i][_x];
	}
	if (v == 0){
		//show_debug_message("Board has been won");
		//show_debug_message(_boardIndex);
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