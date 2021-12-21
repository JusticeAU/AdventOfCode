/// @description 
enum CAVE {
	RISK,
	VISITED,
	SHORTEST
}

function load_input_day_15_2(_path, _scale){
	//read in file to array
	cave = [];
	
	file = file_text_open_read(_path)
	for(var i = 0; (!file_text_eof(file)); i++) {
		var _line = file_text_read_string(file);
		var _length = string_length(_line);
		for (var j = 0; j < _length; j++){
			cave[i][j][CAVE.RISK] = real(string_char_at(_line,j+1));
			cave[i][j][CAVE.VISITED] = false;
			cave[i][j][CAVE.SHORTEST] = infinity;
		}
		file_text_readln(file); 
	}
	file_text_close(file);
	
	//duplicate downwards and accross if required (part 2)
	if(_scale>1){
		var _caveHeight = array_length(cave);
		var _caveLength = array_length(cave[0]);
	
		for (var i = 0; i < _caveHeight; i++){
			for (var j = 0; j < _caveLength; j++){
				var _risk = cave[i][j][CAVE.RISK];
				for (var k = 0; k < _scale; k++){ //duplicate it downwards and across
					for (var l = 0; l < _scale; l++){ 
						cave[i+(k*_caveHeight)][j+(l*_caveLength)][CAVE.RISK] = _risk+k+l <= 9 ? _risk+k+l : (_risk+k+l) mod 9; //if risk is above 9, per instructions roll it back to 1, mod 9 gives us that.
						cave[i+(k*_caveHeight)][j+(l*_caveLength)][CAVE.VISITED] = false;
						cave[i+(k*_caveHeight)][j+(l*_caveLength)][CAVE.SHORTEST] = infinity;
					}
				}
			}
		}
	}
}

function day_15_1(){
	//https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Algorithm
	var _gridHeight = array_length(cave)-1;
	var _gridWidth = array_length(cave[0])-1;
	
	//initiate
	cave[0][0][CAVE.SHORTEST] = 0;
	visitQueue = ds_priority_create();
	ds_priority_add(visitQueue,[0,0],0); //priority queue test
	do{
		//check each neighbor
		current = ds_priority_delete_min(visitQueue);
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
					ds_priority_add(visitQueue,[_x,_y],_costToEnter);
				}
			}
		}
		//mark current location as visited and remove from queue
		cave[current[1]][current[0]][CAVE.VISITED] = true;
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