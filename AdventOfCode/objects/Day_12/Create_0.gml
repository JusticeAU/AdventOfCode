/// @description 
function load_input_day_12(_path){
	caves = [];
	file = file_text_open_read(_path);
	for(var i = 0; (!file_text_eof(file)); i++) {
		_str = file_text_read_string(file);
		var _delimiterPos = string_pos("-",_str);
		var _a = string_copy(_str,1,_delimiterPos-1); 
		var _b = string_copy(_str,_delimiterPos+1,string_length(_str));
		show_debug_message("Reading line: " + _str);
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
		show_debug_message("Creating new Cave: " + _a);
	}
	
	if (_bIndex == -1){
		_bIndex = array_length(caves);
		array_push(caves, new cave(_b));
		show_debug_message("Creating new Cave: " + _b);
	}
	
	show_debug_message("Creating connection between \"" + _a + "\" and \"" + _b + "\"");
	caves[_aIndex].addConnection(_bIndex);
	caves[_bIndex].addConnection(_aIndex);
	
}