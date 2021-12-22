/// @description 
function load_input_day_16(_path){
	var _file = file_text_open_read(_path)
	var _line = file_text_read_string(_file);
	bits = "";
	for(var i = 1; i <= string_length(_line); i++) {
		var _hex = string_char_at(_line,i);
		bits += hex_to_binary(_hex);
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
	processed = [];
	position = 1;
	length = string_length(bits);
	//finished = false;

	repeat(2){
		array_push(processed,read());
		position += (position mod 4)+1; //move up to the next 'quad' due to potential hexadecimal buffer
	}
}

function read_version(){
	var _str = string_copy(bits,position,3);
	position += 3;
	return string_binary_to_decimal(_str);
}
	
function read_type(){
	var _str = string_copy(bits,position,3);
	position += 3;
	return string_binary_to_decimal(_str);
}

function read_packet_type(_type){
	switch(_type){
		case 4: //literal value
			return read_literal();
			break;
	
		default: //operator
			return read_operator();
			break;
	}
}
	
function read_literal(){
	var _more = 1;
	var _str = "";
	do{
		_more = real(string_copy(bits,position,1));
		position += 1
		_str += string_copy(bits,position,4);
		position += 4;
	}
	until(!_more)
	return string_binary_to_decimal(_str);
}

function read_operator(){
	var _lengthType = real(string_copy(bits,position,1));
	position += 1
	switch(_lengthType){
		case 0: //next 15 bits = total length in bits
			var _str = string_copy(bits,position,15);
			position+=15;
			
			var _length = string_binary_to_decimal(_str);
			var _subpackets = string_copy(bits,position,_length);
			position += _length;
			return _subpackets;
			break;
		case 1: //next 11 bits = number of subpackets
			var _str = string_copy(bits,position,11);
			position+=11;
			var _qty = string_binary_to_decimal(_str);
			break;
	}
	
	
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

function read(){
	var _version = read_version();
	var _type = read_type();
	var _data = read_packet_type(_type);
	return [_version,_type,_data];
	
}