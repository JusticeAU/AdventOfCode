/// @description 
function load_input_day_6(_path){
	var file = file_text_open_read(_path);
	var str = file_text_read_string(file);
	var num = "";
	fishes[8] = 0;
	for (var i = 1; i-1 <= string_length(str); i++){ //loop through each character and run through below interpreter
		var char = string_char_at(str,i)
		switch(char){
			case ",": //end fish
				//show_debug_message(num);
				fishes[real(num)] += 1;
				num = "";
				break;
			case "": //end of line/file
				//show_debug_message(num);
				fishes[real(num)] += 1;
				num = "";
				break;
			default: //has to be a char
				num += char;
		}
	}

	
}
	
function day_6(_days){
	repeat(_days){
		var newFish = 0;
		for (var i = 0; i < array_length(fishes); i++){
			switch (i){
				case 0:
					newFish = fishes[0];
					break;
				default:
					fishes[i-1] = fishes[i];
					break;
			}
		}
		fishes[6] += newFish;
		fishes[8] = newFish;
	}
	
	var totalFish = 0;
	for (var i = 0; i < array_length(fishes); i++){
		totalFish += fishes[i];
	}
	return totalFish;
}