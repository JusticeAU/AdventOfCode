/// @description 
function load_input_day_9(_path){
	//read in file to array
	heightmap = [];
	
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		for (var j = 0; j < string_length(_line); j++){
			heightmap[i][j] = real(string_char_at(_line,j+1));
		}
		file_text_readln(file); 
	}
	file_text_close(file);
}

function day_9_1(){
	var riskLevel = 0;
	//scan the map
	for (var _y = 0; _y < array_length(heightmap); _y++){
		for (var _x = 0; _x < array_length(heightmap[_y]); _x++){
			var _adjacent = 0;
			var _adjacentHigher = 0;
			if !(_y == 0){
				_adjacent++;
				_adjacentHigher += (heightmap[_y][_x] < heightmap[_y-1][_x]);
			}
			
			if !(_y == array_length(heightmap)-1){
				_adjacent++;
				_adjacentHigher += (heightmap[_y][_x] < heightmap[_y+1][_x]);
			}
			
			if !(_x == 0){
				_adjacent++;
				_adjacentHigher += (heightmap[_y][_x] < heightmap[_y][_x-1]);
			}
			
			if !(_x == array_length(heightmap[_y])-1){
				_adjacent++;
				_adjacentHigher += (heightmap[_y][_x] < heightmap[_y][_x+1]);
			}
			show_debug_message(_adjacent);
			show_debug_message(_adjacentHigher);
			show_debug_message("---");
			
			
			if (_adjacentHigher == _adjacent) riskLevel += heightmap[_y][_x]+1;
			
		}
	}
	
	show_debug_message(riskLevel);
}