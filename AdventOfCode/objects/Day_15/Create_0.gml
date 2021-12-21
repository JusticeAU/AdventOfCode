/// @description 
enum CAVE {
	RISK,
	VISITED,
	SHORTEST
}

function load_input_day_15(_path){
	//read in file to array
	cave = [];
	
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		for (var j = 0; j < string_length(_line); j++){
			cave[i][j][CAVE.RISK] = real(string_char_at(_line,j+1));
			cave[i][j][CAVE.VISITED] = false;
			cave[i][j][CAVE.SHORTEST] = infinity;
		}
		file_text_readln(file); 
	}
	file_text_close(file);
}

function day_15_1(){
	//https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Algorithm
	var _gridHeight = array_length(cave)-1;
	var _gridWidth = array_length(cave[0])-1;
	
	start = [0,0];
	//initiate
	cave[start[1]][start[0]][CAVE.SHORTEST] = 0;
	visitQueue = [start];
	visitQueueP = ds_priority_create();
	ds_priority_add(visitQueueP,[start],0);
	visitIndex = 0;
	do{
		//check each neighbor
		current = visitQueue[visitIndex]
		neighborQueue = neighbors_4(current,_gridHeight,_gridWidth);
		var _currentShortest = cave[current[1]][current[0]][CAVE.SHORTEST];
		for (var i = 0; i < array_length(neighborQueue); i++){
			var _x = neighborQueue[i][0];
			var _y = neighborQueue[i][1];
		
			if (cave[_y][_x][CAVE.VISITED] != true){
				//consider its current 'shortest cost'
				var _costToEnter = cave[_y][_x][CAVE.RISK] + _currentShortest;
				if(cave[_y][_x][CAVE.SHORTEST] > _costToEnter){
					//set its new cost & add to list of caves to visit
					cave[_y][_x][CAVE.SHORTEST] = _costToEnter;
					array_push(visitQueue,[_x,_y]);
				}
			}
		}
		//mark current location as visited and remove from queue
		cave[current[1]][current[0]][CAVE.VISITED] = true;
		array_delete(visitQueue,visitIndex,1);
		show_debug_message("Queue Length: " + string(array_length(visitQueue)));
		visitIndex = next_location();
		
	}
	until(cave[_gridHeight][_gridWidth][CAVE.VISITED] == true);
	
	return string(cave[_gridHeight][_gridWidth][CAVE.SHORTEST]);
}

//neighbors_4 returns an array of neighbors that are not out of bounds.
function neighbors_4(_xyArray, _maxWidth, _maxHeight){
	var neighbors = [];
	if !(_xyArray[0] == 0) array_push(neighbors, [_xyArray[0]-1,_xyArray[1]]);
	if !(_xyArray[1] == 0) array_push(neighbors, [_xyArray[0],_xyArray[1]-1]);
	if !(_xyArray[0] == _maxWidth) array_push(neighbors, [_xyArray[0]+1,_xyArray[1]]);
	if !(_xyArray[1] == _maxHeight) array_push(neighbors, [_xyArray[0],_xyArray[1]+1]);
	
	return neighbors;
}

function next_location(){
	return 0; //optimisation
	var _lowest = infinity;
	var _lowestIndex = infinity;
	for (i = 0; i < array_length(visitQueue); i++){
		var _x = visitQueue[i][0];
		var _y = visitQueue[i][1];
		if(cave[_y][_x][CAVE.SHORTEST] < _lowest) {
			_lowest = cave[_y][_x][CAVE.SHORTEST]
			_lowestIndex = i;
		}
	}
	return _lowestIndex;
}

function load_input_day_15_2(_path){
	//read in file to array
	cave = [];
	
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		var _length = string_length(_line);
		for (var j = 0; j < _length; j++){
			var _risk = real(string_char_at(_line,j+1));
			for (var k = 0; k < 5; k++){ //duplicate it 5 times to the right.
				cave[i][j+(k*_length)][CAVE.RISK] = _risk+k <= 9 ? _risk+k : (_risk+k) mod 9; //if risk is above 9, per instructions roll it back to 1, mod 9 gives us that.
				cave[i][j+(k*_length)][CAVE.VISITED] = false;
				cave[i][j+(k*_length)][CAVE.SHORTEST] = infinity;
			}
		}
		file_text_readln(file); 
	}
	file_text_close(file);
	
	//duplicate 5 times downwards
	var _caveHeight = array_length(cave);
	var _caveLength = array_length(cave[0]);
	
	for (var i = 0; i < _caveHeight; i++){
		for (var j = 0; j < _caveLength; j++){
			_risk = cave[i][j][CAVE.RISK];
			for (var k = 1; k < 5; k++){ //duplicate it 4 times downwards
				cave[i+(k*_caveHeight)][j][CAVE.RISK] = _risk+k <= 9 ? _risk+k : (_risk+k) mod 9; //if risk is above 9, per instructions roll it back to 1, mod 9 gives us that.
				cave[i+(k*_caveHeight)][j][CAVE.VISITED] = false;
				cave[i+(k*_caveHeight)][j][CAVE.SHORTEST] = infinity;
			}
		}
	}
}