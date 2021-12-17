/// @description 
function load_input_day_14(_path){
	file = file_text_open_read(_path);
	str = file_text_read_string(file);
	charMap = ds_map_create();
	insertionMap = ds_map_create();	
	
	//build initial characters to charArray
	var _strLength = string_length(str);
	for (var i = 1; i <= _strLength; i++){
		var _char = string_char_at(str,i);
		if (i == _strLength) add_neighbor(_char,"EOL", 1);
		else{
			var _neighbor = string_char_at(str,i+1);
			add_neighbor(_char,_neighbor, 1);
		}
	}
	file_text_readln(file);
	file_text_readln(file);
	
	//build insertion rules
	for(var i = 0; (!file_text_eof(file)); i++) {
		//process line of string
		var _str = file_text_read_string(file);
		var _charStr = string_char_at(_str,1);
		var _neighborStr = string_char_at(_str,2);
		var _insertStr = string_char_at(_str,7);
		
		//insert in to map
		if (!ds_map_exists(insertionMap,_charStr)) ds_map_add(insertionMap,_charStr,ds_map_create());
		var _char = insertionMap[? _charStr];
		ds_map_add(_char, _neighborStr, _insertStr);
		
		file_text_readln(file); //next line
	}
	file_text_close(file);
}

function add_char(_charStr){
	if (!ds_map_exists(charMap,_charStr)) ds_map_add(charMap,_charStr,ds_map_create());
}

function add_neighbor(_charStr,_neighborStr, _qty){
	add_char(_charStr);
	var _char = charMap[? _charStr];
	if(!ds_map_exists(_char, _neighborStr)) ds_map_add(_char, _neighborStr, _qty);
	else _char[? _neighborStr] += _qty;
}

function day_14(_steps){
	insertions = [];
	
	for (var _step = 1; _step <= _steps; _step++){
		//build insertion list
		var _charMapSize = ds_map_size(charMap);
		var _char = ds_map_find_first(charMap);
		repeat(_charMapSize){ //loop through charmap
			var _charNeighborMapSize = ds_map_size(charMap[? _char])
			var _neighbor = ds_map_find_first(charMap[? _char]);
			repeat(_charNeighborMapSize){ //loop through neighbors of char
				//search if pair match
				var _insert = insertionMap[? _char][? _neighbor];
				var _quantity = charMap[? _char][? _neighbor];
				array_push(insertions,[_char,_neighbor,_insert,_quantity]);
				
				//find next neighbor
				_neighbor = ds_map_find_next(charMap[? _char], _neighbor);
			}
			
			//find next char
			_char = ds_map_find_next(charMap, _char);
		}
		
		//process insertion list
		for (var i = 0; i < array_length(insertions); i++){
			process_insertion(insertions[i]);
		}
		
		//clear for next step
		insertions = [];
		
		//calc results
		if(_step == 10) get_totals("Part 1: ");
		if(_step == 40) get_totals("Part 2: ");
	}
}

function process_insertion(_array){
	var _char = _array[0];
	var _neighbor = _array[1];
	var _insertion =  _array[2];
	var _qty = _array[3];
	
	if(_insertion == undefined) return 0;
	else{
		//check maps exist
		if (!ds_map_exists(charMap[? _char], _insertion)) add_neighbor(_char, _insertion, 0); //check for insertion qty for char
		if (!ds_map_exists(charMap, _insertion)) add_neighbor(_insertion, _neighbor, 0); //check insertion exists as a char
		if (!ds_map_exists(charMap[? _insertion], _neighbor)) add_neighbor(_insertion, _neighbor, 0); //check for neighbor qty for insertion
				
		//update maps
		charMap[? _char][? _neighbor] -= _qty; //remove the neighbor from its pair
		charMap[? _char][? _insertion] += _qty; //add the insertion as neighbor to the old pair
		charMap[? _insertion][? _neighbor] += _qty; //add the neighbor to its new pair
	}
}

function get_totals(_part){ //same code as building insertion list except were counting the neighbors
	var _largest = 0;
	var _smallest = infinity;
	var _charMapSize = ds_map_size(charMap);
	var _char = ds_map_find_first(charMap);
	repeat(_charMapSize){
		var _charNeighborMapSize = ds_map_size(charMap[? _char])
		var _neighbor = ds_map_find_first(charMap[? _char]);
		var _neighborQty = 0;
		repeat(_charNeighborMapSize){
			_neighborQty += charMap[? _char][? _neighbor];
			_neighbor = ds_map_find_next(charMap[? _char], _neighbor);
		}
		_largest = max(_largest, _neighborQty);
		_smallest = min(_smallest, _neighborQty);
		
		_char = ds_map_find_next(charMap, _char);
	}
	show_debug_message(_part + string(_largest-_smallest));
}