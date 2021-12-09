/// @description 
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
	var fuel_median = 0;
	for (var i = 0; i < array_length(crabs); i++){
		fuel_median += abs(_median - crabs[i]);
	}
	show_debug_message("Part 1: Median: " + string(_median) + " Fuel Cost: " + string(fuel_median));
}

function day_7_2(){
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
			
			//actual formula
			 _fuel_cost += (power(_distance,2) + _distance) / 2;
		}
		if (_fuel_cost < _movement){
			_movement = _fuel_cost;
			_best_pos = i;
		}
	}
	show_debug_message("Part 2: Best Pos: " + string(_best_pos) + " Fuel Cost: " + string(_movement));
}