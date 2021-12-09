/// @description 
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
				case " ": //reached end of first two coordinates, expecting the " -> " notation, so we skip over it to the next coordinate.
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
		//show_debug_message(coordinates[line][x1]);
		
		switch(coordinates[line][x1] == coordinates[line][x2]){
			case true: //vertical
				//show_debug_message("drawing a vertical line");
				for (var target = min(coordinates[line][y1],coordinates[line][y2]); target <= max(coordinates[line][y1],coordinates[line][y2]); target++){
					//show_debug_message("drawing line at: x:" + string(coordinates[line][x1]) + " y:" + string(target));
					grid[# coordinates[line][x1], target] += 1;
					
				}
				break;
			case false: //horizontal
				//show_debug_message("drawing a horizontal line");
				for (var target = min(coordinates[line][x1],coordinates[line][x2]); target <= max(coordinates[line][x1],coordinates[line][x2]); target++){
					//show_debug_message("drawing line at: y:" + string(coordinates[line][y1]) + " x:" + string(target));
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
	show_debug_message("Part 1: " + string(intersections));
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
				//show_debug_message("drawing a vertical line");
				for (var target = min(coordinates[line][y1],coordinates[line][y2]); target <= max(coordinates[line][y1],coordinates[line][y2]); target++){
					//show_debug_message("drawing line at: x:" + string(coordinates[line][x1]) + " y:" + string(target));
					grid[# coordinates[line][x1], target] += 1;
					
				}
				break;
			case "horizontal": //horizontal
				//show_debug_message("drawing a horizontal line");
				for (var target = min(coordinates[line][x1],coordinates[line][x2]); target <= max(coordinates[line][x1],coordinates[line][x2]); target++){
					//show_debug_message("drawing line at: y:" + string(coordinates[line][y1]) + " x:" + string(target));
					grid[# target, coordinates[line][y1]] += 1;
					
				}
				break;
			case "diagonal":
				//show_debug_message("drawing a diagonal line");
				var length = max(coordinates[line][x1],coordinates[line][x2]) - min(coordinates[line][x1],coordinates[line][x2]);
				for (var i = 0; i <= length; i++){
					var target_x = coordinates[line][x1] + (sign(coordinates[line][x2]-coordinates[line][x1])*i)
					var target_y = coordinates[line][y1] + (sign(coordinates[line][y2]-coordinates[line][y1])*i)
					//show_debug_message("drawing at: x:" + string(target_x) + " y:" + string(target_y));
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
	show_debug_message("Part 2: " + string(intersections));
}

function line_orientation(lineIndex){
	if (coordinates[lineIndex][x1] == coordinates[lineIndex][x2]) return "vertical";
	else if (coordinates[lineIndex][y1] == coordinates[lineIndex][y2]) return "horizontal";
	else return "diagonal";
}