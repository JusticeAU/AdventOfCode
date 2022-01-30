/// @description 
if(mouse_check_button_pressed(mb_left))
{
	viewIndex++;
	
	if (viewIndex = array_length(image)) viewIndex = 0;
}