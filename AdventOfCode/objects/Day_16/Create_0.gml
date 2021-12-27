/// @description 
function load_input_day_16(_path){
	var _file = file_text_open_read(_path)
	var _line = file_text_read_string(_file);
	bits = "";
	for(var i = 1; i <= string_length(_line); i++) {
		var _hex = string_char_at(_line,i);
		bits += hex_to_binary(_hex); //convert to binary as we're importing.
	}
	file_text_close(_file);
}

function hex_to_binary(_hex){
	switch(_hex){
		case "0":
			return "0000";
			break;
		case "1":
			return "0001";
			break;
		case "2":
			return "0010";
			break;
		case "3":
			return "0011";
			break;
		case "4":
			return "0100";
			break;
		case "5":
			return "0101";
			break;
		case "6":
			return "0110";
			break;
		case "7":
			return "0111";
			break;
		case "8":
			return "1000";
			break;
		case "9":
			return "1001";
			break;
		case "A":
			return "1010";
			break;
		case "B":
			return "1011";
			break;
		case "C":
			return "1100";
			break;
		case "D":
			return "1101";
			break;
		case "E":
			return "1110";
			break;
		case "F":
			return "1111";
			break;
		
	}
}
	
function day_16(){
	
	position = 1;
	length = string_length(bits);
	processed = decode_one_packet();
	
	show_debug_message("Part 1: " + string(sum_version(processed)));
	show_debug_message("Part 2: " + string(evaluate(processed)));
}

function string_binary_to_decimal(_string){
	var _decimal = 0;
	var _length = string_length(_string);
	for (var i = 1; i <= _length; i++){
		_decimal = _decimal << 1;
		if (string_char_at(_string, i) == "1") _decimal = _decimal | 1;
	}
	return _decimal;
}

function decode_int(_bits){
	var _str = string_copy(bits,position,_bits);
	position+=_bits;
	return _str;
}

function decode_one_packet(){
	var _version = string_binary_to_decimal(decode_int(3));
	var _tid = string_binary_to_decimal(decode_int(3));
	var _data = decode_packet_data(_tid);
	return [_version, _tid, _data];
}

function decode_value_data(){
	var _more = true;
	var _str = ""
	while(_more){
		_more = string_binary_to_decimal(decode_int(1));
		_str += decode_int(4);
	}
	return string_binary_to_decimal(_str);
}

function decode_n_packets(_n){
	var _array = [];
	repeat(_n) array_push(_array, decode_one_packet());
	return _array;
}

function decode_len_packets(_length){
	var _end = position + _length;
	var _array = [];
	
	while(position < _end){
		array_push(_array,decode_one_packet());
	}
	
	return _array;
}

function decode_operator_data(){
	var _ltid = decode_int(1);
	
	if (_ltid == 1) return decode_n_packets(string_binary_to_decimal(decode_int(11)));
	else return decode_len_packets(string_binary_to_decimal(decode_int(15)));
}

function decode_packet_data(_tid){
	if (_tid == 4) return decode_value_data();
	else return decode_operator_data();
}

function sum_version(_packet){
	var _tid = _packet[1];
	var _value = 0;
	_value += _packet[0];
	if (_tid != 4){
		for (var i = 0; i < array_length(_packet[2]); i++){
			_value += sum_version(_packet[2][i]);
		}
	}
	return _value;
}

function evaluate(_packet){
	var _tid = _packet[1];
	switch(_tid){
		case 0:
			return packets_sum(_packet[2]);
			break;
		case 1:
			return packets_product(_packet[2]);
			break;
		case 2:
			return packets_min(_packet[2]);
			break;
		case 3:
			return packets_max(_packet[2]);
			break;
		case 4:
			return _packet[2];
			break;
		case 5:
			return packets_greater(_packet[2]);
			break;
		case 6:
			return packets_less(_packet[2]);
			break;
		case 7:
			return packets_equal(_packet[2]);
			break;
	}
}

function packets_sum(_packet){
	var _value = 0;
	for (var i = 0; i < array_length(_packet); i++){
		var _result = evaluate(_packet[i]);
		_value += _result
	}
	return _value;
}

function packets_product(_packet){
	var _value = 0;
	for (var i = 0; i < array_length(_packet); i++){
		if (i == 0) _value += evaluate(_packet[i]);
		else _value *= evaluate(_packet[i])
	}
	return _value;
}

function packets_min(_packet){
	var _value = infinity;
	for (var i = 0; i < array_length(_packet); i++){
		_value = min(_value,evaluate(_packet[i]));
	}
	return _value;
}

function packets_max(_packet){
	var _value = -1;
	for (var i = 0; i < array_length(_packet); i++){
		_value = max(_value, evaluate(_packet[i]));
	}
	return _value;
}

function packets_greater(_packet){
	return (evaluate(_packet[0]) > evaluate(_packet[1]));
}

function packets_less(_packet){
	return (evaluate(_packet[0]) < evaluate(_packet[1]));
}

function packets_equal(_packet){
	return (evaluate(_packet[0]) == evaluate(_packet[1]));
}