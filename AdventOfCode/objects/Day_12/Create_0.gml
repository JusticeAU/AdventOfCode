/// @description 
function load_input_day_12(_path){
	caves = [];
	file = file_text_open_read(_path);
	for(var i = 0; (!file_text_eof(file)); i++) {
		_str = file_text_read_string(file);
		var _delimiterPos = string_pos("-",_str);
		var _a = string_copy(_str,1,_delimiterPos-1); 
		var _b = string_copy(_str,_delimiterPos+1,string_length(_str));
		//show_debug_message("Reading line: " + _str);
		add_connection(_a,_b)
		
		file_text_readln(file);
	}
	file_text_close(file);
}

cave = function(_name) constructor {
	name = _name;
	big = string_ord_at(_name,1) < 96;
	connections = [];
	
	static addConnection = function(_caveIndex){
		array_push(connections, _caveIndex);
	}
}

function add_connection(_a,_b){
	var	_aIndex = -1,
		_bIndex = -1;
		
	//search for nodes	
	for (var i = 0; i < array_length(caves); i++){
		if (caves[i].name == _a) _aIndex = i;
		else if (caves[i].name == _b) _bIndex = i;
	}
	
	if (_aIndex == -1){
		_aIndex = array_length(caves);
		array_push(caves, new cave(_a));
		//show_debug_message("Creating new Cave: " + _a);
	}
	
	if (_bIndex == -1){
		_bIndex = array_length(caves);
		array_push(caves, new cave(_b));
		//show_debug_message("Creating new Cave: " + _b);
	}
	
	//show_debug_message("Creating connection between \"" + _a + "\" and \"" + _b + "\"");
	caves[_aIndex].addConnection(caves[_bIndex]);
	caves[_bIndex].addConnection(caves[_aIndex]);
	
}
	
function day_12_1(){
	startCave = -1;
	endCave = -1;
	trodden = "";
	paths = [];
	super = -1;
	
	//find start and end cave
	for (var i = 0; i < array_length(caves); i++){
		if (caves[i].name == "start") startCave = caves[i];
		else if (caves[i].name == "end") endCave = caves[i];
	}
	
	walk(startCave,trodden);
	show_debug_message("Part 1: " + string(array_length(paths)));
	paths = [];
	walk2(startCave,trodden,super);
	show_debug_message("Part 2: " + string(array_length(paths)));
}

function walk(_caveID,_trodden){
	_trodden += _caveID.name+",";
	for(var connection = 0; connection < array_length(_caveID.connections); connection++){
		var _hole = _caveID.connections[connection];
		if (_hole.name == "start") continue;
		if (_hole.name == "end") array_push(paths, _trodden+"end");
		else if ((!_hole.big) and (string_count(_hole.name,_trodden) == 1)) continue;
		else walk(_hole, _trodden);
	}
}

function walk2(_caveID,_trodden,_super){
	_trodden += _caveID.name+",";
	for(var connection = 0; connection < array_length(_caveID.connections); connection++){
		var _hole = _caveID.connections[connection];
		if (_hole.name == "start") continue;
		
		if (_hole.name == "end"){
			array_push(paths, _trodden+"end");
			continue;
		}
		
		else if ((!_hole.big) and (string_count(_hole.name,_trodden) == 2)) continue;
		
		walk2(_hole, _trodden,_super);
	}
}
