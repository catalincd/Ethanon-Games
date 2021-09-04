Color ballColor = black;
Color nextBallColor = black;

class GameBackground
{
	ColorGroup currentGroup;
	ColorGroup nextGroup;
	uint currentGroupId;
	uint nextGroupId;
	
	Timer@ timer;
	uint currentColor;
	uint nextColor;
	
	void create()
	{
		@timer = Timer(A_SLOW * 7);
		
		nextGroupId = 0;
		change();
		
		resetColors();
	}
	
	void resetColors()
	{
		//currentGroupId = randOf(Groups.length() - 1);
		//currentGroup = Groups[currentGroupId];
		
		ballColor = currentGroup.ballCol;
		nextBallColor = nextGroup.ballCol;
		
		uint len = currentGroup.group.length() - 1;
		currentColor = randOf(len);
		nextColor = randOf(len, currentColor);
	}
	
	void update()
	{
		timer.update();
		SetBackgroundColor(getColor().getUInt());
		if(timer.isOver())
		{
			timer.reset();
			currentColor = nextColor;
			uint len = currentGroup.group.length() - 1;
			nextColor = randOf(len, currentColor);
		}
	}
	
	Color getColor()
	{
		return interpolate(currentGroup.group[currentColor], currentGroup.group[nextColor], timer.getBias());
	}
	
	void change()
	{
		currentGroupId = nextGroupId;
		uint len = Groups.length() - 1;
		nextGroupId = randOf(len, currentGroupId);
		currentGroup = Groups[currentGroupId];
		nextGroup = Groups[nextGroupId];
		
		timer.reset();
		resetColors();
	}
	
	void resume()
	{
	
	}

}

GameBackground g_gameBackground;

uint randOf(uint len, uint exclude = 999999)
{
	uint current = rand(0, len);
	while(current == exclude)
		current = rand(0, len);
	return current;
}