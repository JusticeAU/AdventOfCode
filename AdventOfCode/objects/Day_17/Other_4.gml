/// @description
load_input_day_17("C:\\dev\\AdventOfCode\\day17.txt");

maxYVelocity = 300; //lets bruteforce it.
for (var _y = targetY2; _y <= maxYVelocity; _y++) //from the lowest point of our target to an abstract high starting Y velicity.
{
	for (var _x = 0; _x <= targetX2; _x++) //from 0 to farthest point of our target square
	{
		var result = fireProbe(_x,_y)
		highestY = max(highestY, result); //update highest (for part 1)
		if (result != -4) successes += 1; //increment successful target hits (for part2)
	}
}

show_debug_message("Part 1: Highest Y: " + string(highestY));
show_debug_message("Part 2: Successes: " + string(successes));
