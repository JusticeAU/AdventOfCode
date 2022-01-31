/// @description 
targetX1 = -4;
targetX2 = -4;
targetY1 = -4;
targetY2 = -4;

highestY = 0;
successes = 0;

function load_input_day_17(_path)
{
	var file = file_text_open_read(_path);
	var _line = file_text_read_string(file);
	
	//find X1
	var _pos = string_pos("x=",_line)+2;
	var _posEnd = string_pos("..",_line);
	targetX1 = real(string_copy(_line,_pos,_posEnd-_pos));
	//find X2
	_pos = _posEnd+2
	_posEnd = string_pos(",",_line);
	targetX2 = real(string_copy(_line,_pos,_posEnd-_pos));
	//find Y2 (honestly why is this backwards in the input?)
	_pos = string_pos("y=",_line)+2;
	_posEnd = string_pos_ext("..",_line,_pos);
	targetY2 = real(string_copy(_line,_pos,_posEnd-_pos));
	//find Y1
	_pos = _posEnd+2;
	_posEnd = string_length(_line)+1;
	targetY1 = real(string_copy(_line,_pos,_posEnd-_pos));
	
	file_text_close(file);
}

function fireProbe(velocityX, velocityY)
{
	var xPos = 0;
	var yPos = 0;
	var thisHighestY = 0;
	
	while(true)
	{

		xPos += velocityX;
		yPos += velocityY;
		
		thisHighestY = max(thisHighestY, yPos);
		
		velocityX = max(0,velocityX-1);
		velocityY -= 1;
		
		if(yPos < targetY2) //check if we are lower than the target area
		{
			return -4;
		}
		else if ((xPos >= targetX1) and (xPos <= targetX2) and (yPos <= targetY1)) //if we're not, check if we're in the other bounds of the target area.
		{
			return thisHighestY;
		}
		
	}
}
