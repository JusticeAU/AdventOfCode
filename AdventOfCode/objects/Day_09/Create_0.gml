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
			
			if (_adjacentHigher == _adjacent) riskLevel += heightmap[_y][_x]+1;
		}
	}
	
	show_debug_message("Part 1: " + string(riskLevel));
}
	
function day_9_2(){
	//determine regions
	regionIndex = -1;
	//pass 1
	for (var _y = 0; _y < array_length(heightmap); _y++){
		for (var _x = 0; _x < array_length(heightmap[_y]); _x++){
			var _height = heightmap[_y][_x];
			
			if(_height != 9){
				//check for
				var _joinedRegion = false;
				if !(_y == 0){ //check above
					if (sign(heightmap[_y-1][_x]) == -1){
						heightmap[_y][_x] = heightmap[_y-1][_x];
						_joinedRegion = true;
					}
				}
						
				if !(_x == 0) and !(_joinedRegion) { //check behind
					if (sign(heightmap[_y][_x-1]) == -1){
						heightmap[_y][_x] = heightmap[_y][_x-1];
						_joinedRegion = true;
					}
				}
				if (!_joinedRegion){
					heightmap[_y][_x] = regionIndex;
					regionIndex--;
				}
			}
		}
	}
	
	//merge touching regions
	for (var _y = 0; _y < array_length(heightmap); _y++){
		for (var _x = 0; _x < array_length(heightmap[_y]); _x++){
			var _currentRegion = heightmap[_y][_x];
			if(_currentRegion != 9){ //not 'wall'
				//check for touching region below and infront
				if !(_y == array_length(heightmap)-1){ //not bottom
					compare_cell(_x,_y,0,1);
				}
				
				if !(_x == array_length(heightmap[_y])-1) { //not right
					compare_cell(_x,_y,1,0);
				}
			}
			
		}
	}
	
	//calculate largest 3 regions
	regionSizes[abs(regionIndex)] = 0;
	
	for (var _y = 0; _y < array_length(heightmap); _y++){
		for (var _x = 0; _x < array_length(heightmap[_y]); _x++){
			if (sign(heightmap[_y][_x]) == -1) regionSizes[abs(heightmap[_y][_x])] += 1;
		}
	}
	
	array_sort(regionSizes,false);
	var _result = regionSizes[0]*regionSizes[1]*regionSizes[2];
	show_debug_message("Part 2: " + string(_result));
}

function compare_cell(_target_x, _target_y, _compare_x_offset, _compare_y_offset){
	var _target_value = heightmap[_target_y][_target_x];
	var _compare_value = heightmap[_target_y + _compare_y_offset][_target_x + _compare_x_offset];
	if((_compare_value != 9) and (_compare_value != _target_value)) merge_region(_target_value, _compare_value);
}

function merge_region(_region, _become){
	//show_debug_message("Merging " + string(_region) + " with " + string(_become));
	for (var _y = 0; _y < array_length(heightmap); _y++){
		for (var _x = 0; _x < array_length(heightmap[_y]); _x++){
			if (heightmap[_y][_x] == _region) heightmap[_y][_x] = _become;
		}
	}
}