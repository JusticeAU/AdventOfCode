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
	finished = false;

	show_debug_message(read_version());
}

function read_version(){
	var _str = string_copy(bits,position,3);
	switch(_str){
		case "000":
			return 0;
			break;
		case "001":
			return 1;
			break;
		case "010":
			return 2;
			break;
		case "011":
			return 3;
			break;
		case "100":
			return 4;
			break;
		case "101":
			return 5;
			break;
		case "110":
			return 6;
			break;
		case "111":
			return 7;
			break;
	}
}