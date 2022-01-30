/// @description 
function load_input_day_21(_path){
	var file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		var _end = string_length(_line);
		var _start = real(string_copy(_line,_end,1));
		players[i] = [_start,0];
		file_text_readln(file); 
	}
	file_text_close(file);
}

function day_21_1(){
	rolls = 0;
	currentPlayer = 0;
	gameover = false;
	
	do{
		player_turn(currentPlayer);
		if (players[currentPlayer][1] > 999) gameover = true;
		else currentPlayer = !currentPlayer;
	}
	until(gameover)
	
	show_debug_message("Part 1: " + string(players[!currentPlayer][1] * rolls));
}

function roll_die(){
	static value = 0;
	value += 1;
	rolls += 1;
	
	if (value > 100) value = 1;
	return value;
}

function player_turn(_player){
	var _move = 0;
	repeat(3) _move += roll_die();
	_move = _move mod 10;
	players[_player][0] += _move;
	if (players[_player][0] > 10) players[_player][0] -= 10;
	players[_player][1] += players[_player][0];
	
}