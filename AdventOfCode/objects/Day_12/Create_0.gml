/// @description 
function load_input_day_12(_path){
	caves = [];
	file = file_text_open_read(_path);
	for(var i = 0; (!file_text_eof(file)); i++) {
		_str = file_text_read_string(file);
		var _delimiterPos = string_pos("-",_str); //find the delimiter between the two caves
		var _a = string_copy(_str,1,_delimiterPos-1);  //find the string before the delimiter
		var _b = string_copy(_str,_delimiterPos+1,string_length(_str)); //find the string after the delimiter
		add_connection(_a,_b)
		file_text_readln(file);
	}
	file_text_close(file);
}

cave = function(_name) constructor {
	name = _name;
	big = string_ord_at(_name,1) < 96; //check if char is capitalised or not.
	connections = []; //init the array for its connections
	
	static addConnection = function(_caveIndex){
		array_push(connections, _caveIndex);
	}
}

function add_connection(_a,_b){
	var	_aIndex = -1, //holders to find our indexes in the list (if they exist)
		_bIndex = -1;
		
	for (var i = 0; i < array_length(caves); i++){ //search existing nodes	
		if (caves[i].name == _a) _aIndex = i;
		else if (caves[i].name == _b) _bIndex = i;
	}
	
	if (_aIndex == -1){ //if didnt find matches, we need to create them.
		_aIndex = array_length(caves);
		array_push(caves, new cave(_a));
	}
	
	if (_bIndex == -1){
		_bIndex = array_length(caves);
		array_push(caves, new cave(_b));
	}
	
	caves[_aIndex].addConnection(caves[_bIndex]); //connect the two now existing caves per initial intention
	caves[_bIndex].addConnection(caves[_aIndex]);
	
}
	
function day_12_1(){
	startCave = -1;
	endCave = -1;
	trodden = "";
	paths = [];
	
	
	for (var i = 0; i < array_length(caves); i++){ //find start and end cave
		if (caves[i].name == "start") startCave = caves[i];
		else if (caves[i].name == "end") endCave = caves[i];
	}
	
	walk(startCave,trodden,true); //walk the cave for part1 - true means we have already used our part2 'ability' to walk in to a single small cave twice.
	show_debug_message("Part 1: " + string(array_length(paths)));
	paths = []; //reset the list of pathes for part2
	walk(startCave,trodden,false);
	show_debug_message("Part 2: " + string(array_length(paths)));
}

function walk(_caveID,_trodden,_super){
	_trodden += _caveID.name+","; //build our path
	for(var connection = 0; connection < array_length(_caveID.connections); connection++){ //for each connection
		var _sup = _super; //store if our super has been used when considering this connection only
		var _hole = _caveID.connections[connection];
		
		if (_hole == startCave) continue;
		else if (_hole == endCave){ //path complete, push to list and stop.
			array_push(paths, _trodden+endCave.name);
			continue;
		}
		else if ((!_hole.big) and (string_count(_hole.name,_trodden) >= 1) and (_sup == true)) continue; //we're trying to walk in to a visited small cave and have no super
		else if ((!_hole.big) and (string_count(_hole.name,_trodden) >= 1)) _sup = true;//we're trying to walk in to a visited small cave but we havent used our super.
		
		walk(_hole, _trodden,_sup); //valid path
	}
}
