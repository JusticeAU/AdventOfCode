/// @description 
function load_input_day_8(_path){
	display = [];
	var file = file_text_open_read(_path);
	
	var line = 0;
	var index = 0;
	var signal = "";	
	
	while (!file_text_eof(file)) {
		var delimited = false;
		var str = file_text_read_string(file);
		array_push(display,[]);
		array_push(display[line],[]);
		array_push(display[line],[]);
		for (var i = 1; i-1 <= string_length(str); i++){
			switch(string_char_at(str,i)){
				case " ":
					array_push(display[line][delimited],signal);
					signal = "";
					break;
				case "|":
					i++
					delimited = true;
					break;
				case "":
					array_push(display[line][delimited],signal);
					signal = "";
					line++;
					file_text_readln(file);
					break;
				default:
					signal += string_char_at(str,i);
					break;
			}
		}
	}
}
	
function day_8_1(){
	var answer = 0;
	for (var i = 0; i < array_length(display); i++){
		for (var j = 0; j < array_length(display[i][1]); j++){
			var length = string_length(display[i][1][j]);
			switch(length){
				case 2:
					answer += 1;
					break;
				case 3:
					answer += 1;
					break;
				case 4:
					answer += 1;
					break;
				case 7:
					answer += 1;
					break;
				default:
					break;
			}
		}
	}
	show_debug_message("Part 1: " + string(answer));
}
	
function day_8_2(){
	//loop through the whole array of data
	for (var lineIndex = 0; lineIndex < array_length(display); lineIndex++){
		var digits =["abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg",
					"abcdefg"];
		//solve digits
		#region //Digit 1, 4, 7 and 8
		//find the str with length 2 - this is digit 1
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 2){
				digits[1] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
	
		//find the str with length 4 - this is digit 4
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 4){
				digits[4] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
	
		//find the str with length 3 - this is digit 7
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 3){
				digits[7] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
	
		//find the str with length 7 - this is digit 8
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 7){
				digits[8] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
		#endregion
		#region //Digit 3			
		//3 will have 5 bits AND contain the bits from 1.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 5){
				var matched = 0;
			
				//check if candidate the 2 bits from the 1 digit.
				for (var oneBits = 1; oneBits <= string_length(digits[1]); oneBits++){
					var oneBit = string_char_at(digits[1],oneBits);
					for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
						var potentialBit = string_char_at(str,potentialBits);
						if (oneBit == potentialBit){
							matched++;
						
						}
					}
					
				}
				if (matched = 2){ //found 3
					digits[3] = str;
					array_delete(display[lineIndex][0], strIndex, 1);
					break;
				}
			}
		}
		#endregion
		#region //Digit 6
		//6 will have 6 bits AND be missing a bit from 1.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 6){
				var matched = 0;
			
				//check if candidate is missing one of the bits from 1.
				for (var oneBits = 1; oneBits <= string_length(digits[1]); oneBits++){
					var oneBit = string_char_at(digits[1],oneBits);
					for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
						var potentialBit = string_char_at(str,potentialBits);
						if (oneBit == potentialBit){
							matched++;
						
						}
					}
					
				}
				if (matched = 1){ //found 6
					digits[6] = str;
					array_delete(display[lineIndex][0], strIndex, 1);
					break;
				}
			}
		}
	
		#endregion
		#region //Digit 9
		//9 will have 6 bits AND contain the bits from 4.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 6){
				var matched = 0;
			
				//check if candidate has the 4 bits from the 4 digit.
				for (var fourBits = 1; fourBits <= string_length(digits[4]); fourBits++){
					var fourBit = string_char_at(digits[4],fourBits);
					for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
						var potentialBit = string_char_at(str,potentialBits);
						if (fourBit == potentialBit){
							matched++;
						
						}
					}
					
				}
				if (matched = 4){ //found 4
					digits[9] = str;
					array_delete(display[lineIndex][0], strIndex, 1);
					break;
				}
			}
		}
		#endregion
		#region //Digit 0
		//0 will be the only remaining 6 digit bit.
		for (var strIndex = 0; strIndex <array_length(display[lineIndex][0]); strIndex++){
			var str = display[lineIndex][0][strIndex];
			if(string_length(str) == 6){
				digits[0] = str;
				array_delete(display[lineIndex][0], strIndex, 1);
				break;
			}
		}
		#endregion
		#region //Digit 2 and leaves 5
		//2 will have 5 bits and contain the missing bit from 6.
		//get missing bit from 6
		var missingBit = "abcdefg";
		for (var sixBits = 1; sixBits <= string_length(digits[6]); sixBits++){
			var sixBit = string_char_at(digits[6],sixBits);
			missingBit = string_replace(missingBit,sixBit,"");
		}
	
		//check if contains the missing bit
		repeat(2){
			var str = display[lineIndex][0][0];
			var matched = 0;
			
			//check if candidate contains the missing bit
			for (var potentialBits = 1; potentialBits <= string_length(str); potentialBits++){
				var potentialBit = string_char_at(str,potentialBits);
				if (missingBit == potentialBit){
					matched++;
						
				}
			}
		
			if (matched = 1){ //found 2
				digits[2] = str;
				array_delete(display[lineIndex][0], 0, 1);
			}
			else{ //found 5
				digits[5] = str;
				array_delete(display[lineIndex][0], 0, 1);
			}
		
		}
		#endregion
	
		#region //Match decrypted digits with display
		for (var digitIndex = 0; digitIndex < array_length(display[lineIndex][1]); digitIndex++){//process the 4? numbers
			var matched = false;
			var digitStr = display[lineIndex][1][digitIndex];
			var digitLength = string_length(digitStr);
			for (var potentialMatch = 0; potentialMatch < 10; potentialMatch++){
				var potentialMatchStr = digits[potentialMatch]
				var potentialMatchLength = string_length(potentialMatchStr);
			
				if (potentialMatchLength == digitLength){ //display digit has same length as digit index
					var matches = 0;
					for (var char1Index = 1; char1Index <= digitLength; char1Index++){
						var char1 = string_char_at(digitStr, char1Index);
						for (var char2Index = 1; char2Index <= digitLength; char2Index++){
							var char2 = string_char_at(potentialMatchStr, char2Index);
							if (char1 == char2){
								matches++;
							}
						}
					}
					if (matches == digitLength){
						display[lineIndex][1][digitIndex] = potentialMatch;
						matched = true;
					}
				}
				if (matched) break;
			}
		}
		#endregion
		
	}
	
	//sum the solved data
	var result = 0;
	for (var line = 0; line < array_length(display); line++){
		for (var digit = 0; digit < array_length(display[line][1]); digit++){
			switch (digit){
				case 0:
					result += (display[line][1][digit]) * 1000;
					break;
				case 1:
					result += (display[line][1][digit]) * 100;
					break;
				case 2:
					result += (display[line][1][digit]) * 10;
					break;
				case 3:
					result += (display[line][1][digit]);
					break;
			}
		}
	}
	show_debug_message("Part 2: " + string(result));
	
}
